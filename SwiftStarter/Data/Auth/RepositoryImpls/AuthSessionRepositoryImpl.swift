//
//  AuthSessionRepositoryImpl.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

final class AuthSessionRepositoryImpl: AuthSessionRepository {
    private let authSessionService: AuthSessionService
    private let authAcesssTokenStorage: TokenStorage

    init(
        authSessionService: AuthSessionService,
        authAcesssTokenStorage: TokenStorage
    ) {
        self.authSessionService = authSessionService
        self.authAcesssTokenStorage = authAcesssTokenStorage
    }

    func create(
        _ request: CreateSessionRequestDTO
    ) async throws {
        let session =
            try await authSessionService
            .create(request)
            .toDomain()
        try authAcesssTokenStorage.save(token: session.token)
    }

}
