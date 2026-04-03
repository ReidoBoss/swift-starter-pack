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
            AuthSessionServiceImpl(
                client: self.apiClient(),
                authenticatedClient: self.authenticatedApiClient()
            )
        }.shared
    }

    var authSessionRepository: Factory<AuthSessionRepository> {
        self { @MainActor in
            AuthSessionRepositoryImpl(
                authSessionService: self.authSessionService()
            )
        }.shared
    }

    var createSessionUsecase: Factory<any CreateSessionUsecase> {
        self { @MainActor in
            CreateSessionUsecaseImpl(
                authSessionRepository: self.authSessionRepository(),
                authTokenStorage: self.authTokenStorage(),
                userStorage: self.userStorage()
            )
        }.shared
    }

    var deleteSessionUsecase: Factory<DeleteSessionUsecase> {
        self { @MainActor in
            DeleteSessionImpl(
                authTokenStorage: self.authTokenStorage(),
                userStorage: self.userStorage()
            )
        }
    }

    var sessionViewModel: Factory<SessionViewModel> {
        self { @MainActor in
            .init(
                createSessionUsecase: self.createSessionUsecase(),
                deleteSessionUsecase: self.deleteSessionUsecase()
            )
        }.shared
    }

}
