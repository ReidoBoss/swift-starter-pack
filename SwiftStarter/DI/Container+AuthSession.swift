//
//  Container+AuthSession.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Factory
import Foundation

extension Container {
    var authSessionService: Factory<AuthSessionService> {
        self { @MainActor in
            AuthSessionServiceImpl(client: self.apiClient())
        }.shared
    }

    var authSessionRepository: Factory<AuthSessionRepository> {
        self { @MainActor in
            AuthSessionRepositoryImpl(
                authSessionService: self.authSessionService(),
                authAcesssTokenStorage: self.authTokenStorage()
            )
        }.shared
    }
}
