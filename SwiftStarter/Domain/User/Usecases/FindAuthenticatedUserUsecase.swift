//
//  FindAuthenticatedUserUsecase.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

protocol FindAuthenticatedUserUsecase {
    func execute() async throws -> User
}

final class FindAuthenticatedUserImpl: FindAuthenticatedUserUsecase {

    let repository: AuthSessionRepository

    init(
        repository: AuthSessionRepository
    ) {
        self.repository = repository
    }

    func execute() async throws -> User {
        try await repository.find()
    }
}
