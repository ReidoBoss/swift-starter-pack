//
//  Container+Networking.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/20/26.
//

import Alamofire
import Factory
import Foundation

// MARK: - Factory Container Extension

extension Container {

    // MARK: - Base URL

    /// Resolves to the correct base URL for the current build configuration.
    var apiBaseURL: Factory<URL> {
        self {
            #if DEBUG
                // Use staging in debug builds
                URL(string: "https://dummyjson.com")!
            #else
                URL(string: "https://dummyjson.com")!
            #endif
        }
        .singleton
    }

    // MARK: - Session

    /// Alamofire session with auth interceptor attached.
    /// Swap this registration in tests to inject a mock session.
    var alamofireSession: Factory<Session> {
        self {
            let refreshEndpoint =
                self
                .apiBaseURL()
                .appendingPathComponent("/auth/refresh")

            let interceptor = AuthInterceptor(
                tokenStorage: self.authTokenStorage(),
                refreshEndpoint: refreshEndpoint
            )

            return Session(interceptor: interceptor)
        }
        .singleton
    }

    // MARK: - APIClient

    /// The app-wide `APIClientProtocol` implementation.
    var apiClient: Factory<APIClientProtocol> {
        self { @MainActor in
            AlamofireAPIClient(
                baseURL: self.apiBaseURL(),
                session: self.alamofireSession()
            )
        }
        .singleton
    }

}
