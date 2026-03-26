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
                URL(string: "https://staging-api.skloud.ph/v1")!
            #else
                URL(string: "https://api.skloud.ph/v1")!
            #endif
        }
        .singleton
    }

    // MARK: - Session

    /// Alamofire session with auth interceptor attached.
    /// Swap this registration in tests to inject a mock session.
    var alamofireSession: Factory<Session> {
        self {
            // Attach a token refresh interceptor here when auth is implemented.
            Session.default
        }
        .singleton
    }

    // MARK: - APIClient

    /// The app-wide `APIClientProtocol` implementation.
    var apiClient: Factory<any APIClientProtocol> {
        self { @MainActor in
            AlamofireAPIClient(
                baseURL: self.apiBaseURL(),
                session: self.alamofireSession()
            )
        }
        .singleton
    }

    //    // MARK: - Services
    //
    //    /// Youth Profile service. Scoped to `.shared` so all consumers share one instance.
    //    var youthProfileService: Factory<any YouthProfileServiceProtocol> {
    //        self {
    //            YouthProfileService(client: self.apiClient())
    //        }
    //        .shared
    //    }
}
