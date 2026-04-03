//
//  AuthSessionRepository.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

protocol AuthSessionRepository {
    func create(
        _ request: CreateSessionRequestDTO
    ) async throws -> AuthSession

    func find() async throws -> User?
}
