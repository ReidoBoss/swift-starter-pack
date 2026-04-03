//
//  AuthSessionRepositoryImpl.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

final class AuthSessionRepositoryImpl: AuthSessionRepository {
    private let authSessionService: AuthSessionService

    init(
        authSessionService: AuthSessionService,
    ) {
        self.authSessionService = authSessionService
    }

    func create(
        _ request: CreateSessionRequestDTO
    ) async throws -> AuthSession {
        try await authSessionService
            .create(request)
            .toDomain()
    }

    func find() async throws -> User? {
        try await authSessionService
            .find()
            .toDomain()
    }

}
