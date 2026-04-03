//
//  AuthSessionService.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Foundation

protocol AuthSessionService {
    func create(
        _ sessionDto: CreateSessionRequestDTO
    ) async throws -> CreateSessionResponseDTO

    func find() async throws -> FindAuthenticatedSessionResponseDTO
}
