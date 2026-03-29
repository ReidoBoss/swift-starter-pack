//
//  AuthSessionService.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

protocol AuthSessionService {
    func create(
        _ sessionDto: CreateSessionRequestDTO
    ) async throws -> CreateSessionResponseDTO

    func find() async throws -> FindAuthenticatedSessionResponseDTO
}

final class AuthSessionServiceImpl: AuthSessionService {
    private let client: APIClientProtocol

    init(client: APIClientProtocol) {
        self.client = client
    }

    func create(
        _ sessionDto: CreateSessionRequestDTO
    ) async throws -> CreateSessionResponseDTO {
        try await client.request(
            SessionEndpoint.create(request: sessionDto),
            as: CreateSessionResponseDTO.self
        )
    }

    func find() async throws -> FindAuthenticatedSessionResponseDTO {
        try await client.request(
            SessionEndpoint.find,
            as: FindAuthenticatedSessionResponseDTO.self
        )
    }
}
