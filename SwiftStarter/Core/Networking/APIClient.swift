//
//  APIClient.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/20/26.
//

import Alamofire
import Foundation

// MARK: - Protocol

/// The single entry point for executing network requests.
/// Keeping this protocol thin ensures easy mocking in tests.
protocol APIClientProtocol {
    /// Executes an endpoint request and decodes the response into `T`.
    /// - Parameters:
    ///   - endpoint: The `Endpoint` describing the request.
    ///   - type: The `Decodable` type to map the response into.
    /// - Returns: A decoded instance of `T`.
    /// - Throws: `APIError` on failure.
    func request<T: Decodable & Sendable>(
        _ endpoint: any Endpoint,
        as type: T.Type
    ) async throws -> T
}

// MARK: - Alamofire Implementation

/// Concrete `APIClientProtocol` backed by Alamofire.
/// This is the only file in the app that imports Alamofire directly
/// (aside from Endpoint.swift for HTTPMethod/encoding types).
final class AlamofireAPIClient: APIClientProtocol {

    // MARK: - Dependencies

    private let session: Session
    private let baseURL: URL
    private let decoder: JSONDecoder

    // MARK: - Init

    /// - Parameters:
    ///   - baseURL: Root URL. All endpoint paths are appended to this.
    ///   - session: Alamofire session. Defaults to `.default`; inject a custom one for auth interceptors.
    ///   - decoder: JSON decoder. Defaults to snake\_case + ISO8601 date strategy.
    init(
        baseURL: URL,
        session: Session = .default,
        decoder: JSONDecoder = .skDefault
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    // MARK: - APIClientProtocol

    func request<T: Decodable & Sendable>(
        _ endpoint: any Endpoint,
        as type: T.Type
    ) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint.path)

        let dataTask = session.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        .validate()  // Triggers httpError for non-2xx automatically

        return try await withCheckedThrowingContinuation { continuation in
            dataTask.responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoded = try self.decoder.decode(
                            T.self,
                            from: data
                        )
                        continuation.resume(returning: decoded)
                    } catch {
                        continuation.resume(
                            throwing: APIError.decodingFailed(underlying: error)
                        )
                    }

                case .failure(let afError):
                    // Surface HTTP status codes distinctly from transport errors.
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(
                            throwing: APIError.httpError(
                                statusCode: statusCode,
                                data: response.data
                            )
                        )
                    } else {
                        continuation.resume(
                            throwing: APIError.requestFailed(
                                underlying: afError
                            )
                        )
                    }
                }
            }
        }
    }
}

// MARK: - JSONDecoder Default Configuration

extension JSONDecoder {
    /// App-wide decoder: snake\_case keys, ISO8601 dates.
    static var skDefault: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
