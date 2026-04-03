//
//  AuthInterceptor.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Alamofire
import Foundation

/// Alamofire `RequestInterceptor` that automatically attaches the access token
/// to every outgoing request and silently refreshes it on a `401` response.
///
/// Inject this into `Session` at composition time — `AlamofireAPIClient` requires no changes.

final class AuthInterceptor: RequestInterceptor, @unchecked Sendable {

    // MARK: - Dependencies

    private let tokenStorage: AuthTokenStorage
    private let refreshEndpoint: URL

    // MARK: - State

    /// Prevents multiple concurrent refresh requests from racing.
    private let lock = NSLock()
    private var isRefreshing = false
    private var pendingRetries: [(RetryResult) -> Void] = []

    // MARK: - Init

    /// - Parameters:
    ///   - tokenStorage: The `TokenStorage` instance that holds access and refresh tokens.
    ///   - refreshEndpoint: The full URL of the token refresh endpoint.
    init(tokenStorage: AuthTokenStorage, refreshEndpoint: URL) {
        self.tokenStorage = tokenStorage
        self.refreshEndpoint = refreshEndpoint
    }

    // MARK: - Adapt

    /// Attaches the stored access token as a `Bearer` Authorization header before the request is sent.
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        do {
            if let token = try tokenStorage.get(type: .access) {
                var request = urlRequest
                request.setValue(
                    "Bearer \(token)",
                    forHTTPHeaderField: "Authorization"
                )
                completion(.success(request))
            }
        } catch {
            completion(.failure(error))
        }
    }

    // MARK: - Retry

    /// Called after a failed response. On `401`, attempts a silent token refresh then retries.
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        // Only intercept HTTP 401 Unauthorized
        guard
            let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401,
            request.retryCount == 0  // Prevent infinite retry loops
        else {
            completion(.doNotRetry)
            return
        }

        lock.lock()
        pendingRetries.append(completion)

        guard !isRefreshing else {
            // A refresh is already in flight — queue this retry to resume after it finishes
            lock.unlock()
            return
        }

        isRefreshing = true
        lock.unlock()

        //        Task {
        //            await performRefresh()
        //        }
    }
}

// MARK: - Private Refresh Logic

extension AuthInterceptor {

    /// Exchanges the stored refresh token for a new token pair, then resolves all pending retries.
    fileprivate func performRefresh() async {
        do {
            guard
                let refreshToken =
                    try await tokenStorage
                    .get(type: .refresh)
            else {
                throw APIError.sessionExpired
            }

            var request = URLRequest(url: refreshEndpoint)
            request.httpMethod = "POST"
            request.setValue(
                "Bearer \(refreshToken)",
                forHTTPHeaderField: "Authorization"
            )

            let (data, response) = try await URLSession.shared.data(
                for: request
            )

            guard
                let http = response as? HTTPURLResponse,
                (200..<300).contains(http.statusCode)
            else {
                throw APIError.sessionExpired
            }

            let decoder = await JSONDecoder.customDefault
            let tokens = try decoder.decode(
                CreateSessionResponseDTO.self,
                from: data
            )

            try await tokenStorage.save(
                token: tokens.accessToken,
                type: .access
            )
            try await tokenStorage.save(
                token: tokens.refreshToken,
                type: .refresh
            )

            resolvePending(shouldRetry: true)

        } catch {
            // Refresh failed — wipe tokens and force re-login
            try? await tokenStorage.clear()
            resolvePending(shouldRetry: false)
        }
    }

    /// Resolves all queued retry completions and resets refresh state.
    fileprivate func resolvePending(shouldRetry: Bool) {
        lock.lock()
        let completions = pendingRetries
        pendingRetries.removeAll()
        isRefreshing = false
        lock.unlock()

        let result: RetryResult =
            shouldRetry ? .retry : .doNotRetryWithError(APIError.sessionExpired)
        completions.forEach { $0(result) }
    }
}
