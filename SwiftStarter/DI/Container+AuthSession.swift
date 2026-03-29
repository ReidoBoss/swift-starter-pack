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
                authSessionStorage: self.authTokenStorage()
            )
        }.shared
    }

    var createSessionUsecase: Factory<any CreateSessionUsecase> {
        self { @MainActor in
            CreateSessionUsecaseImpl(
                authSessionRepository: self.authSessionRepository()
            )
        }.shared
    }

    var sessionViewModel: Factory<SessionViewModel> {
        self { @MainActor in
            .init(createSessionUsecase: self.createSessionUsecase())
        }.shared
    }

}
