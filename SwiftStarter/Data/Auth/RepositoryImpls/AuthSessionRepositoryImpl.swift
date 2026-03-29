//
//  AuthSessionRepositoryImpl.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

final class AuthSessionRepositoryImpl: AuthSessionRepository {
    private let authSessionService: AuthSessionService
    private let authSessionStorage: AuthTokenStorage

    init(
        authSessionService: AuthSessionService,
        authSessionStorage: AuthTokenStorage
    ) {
        self.authSessionService = authSessionService
        self.authSessionStorage = authSessionStorage
    }

    func create(
        _ request: CreateSessionRequestDTO
    ) async throws {
        let session =
            try await authSessionService
            .create(request)
            .toDomain()

        try authSessionStorage.save(
            token: session.accessToken,
            type: .access
        )

        try authSessionStorage.save(
            token: session.refreshToken,
            type: .refresh
        )
    }

    func find() async throws -> User {
        try await authSessionService
            .find()
            .toDomain()
    }

}
