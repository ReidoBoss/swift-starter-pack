//
//  CreateSessionUsecase.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

protocol CreateSessionUsecase {
    func execute(
        _ input: CreateSessionInput
    ) async throws
}

final class CreateSessionUsecaseImpl: CreateSessionUsecase {

    let authSessionRepository: AuthSessionRepository
    let authTokenStorage: AuthTokenStorage
    let userStorage: UserStorage

    init(
        authSessionRepository: AuthSessionRepository,
        authTokenStorage: AuthTokenStorage,
        userStorage: UserStorage
    ) {
        self.authSessionRepository = authSessionRepository
        self.authTokenStorage = authTokenStorage
        self.userStorage = userStorage
    }

    func execute(
        _ input: CreateSessionInput
    ) async throws {

        let session = try await authSessionRepository.create(input.toDTO())

        try authTokenStorage
            .save(
                token: session.accessToken,
                type: .access
            )

        try authTokenStorage
            .save(
                token: session.refreshToken,
                type: .refresh
            )

        userStorage
            .save(user: session.toUser())

    }
}
