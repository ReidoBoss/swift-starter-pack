//
//  AuthSessionServiceImpl.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

final class AuthSessionServiceImpl: AuthSessionService {
    private let client: APIClientProtocol
    private let authenticatedClient: APIClientProtocol

    init(
        client: APIClientProtocol,
        authenticatedClient: APIClientProtocol
    ) {
        self.client = client
        self.authenticatedClient = authenticatedClient
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
        try await authenticatedClient.request(
            SessionEndpoint.find,
            as: FindAuthenticatedSessionResponseDTO.self
        )
    }

}
