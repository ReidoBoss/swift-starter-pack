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

    init(
        authSessionRepository: AuthSessionRepository
    ) {
        self.authSessionRepository = authSessionRepository
    }

    func execute(
        _ input: CreateSessionInput
    ) async throws {
        let email = input.email
        let password = input.password

        guard email.contains("@") else { throw AuthError.invalidEmail }
        guard password.count >= 8 else { throw AuthError.weakPassword }

        try await authSessionRepository.create(input.toDTO())
    }
}
