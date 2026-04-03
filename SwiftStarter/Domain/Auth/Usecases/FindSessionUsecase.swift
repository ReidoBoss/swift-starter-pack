//
//  FindSessionUsecase.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Foundation

protocol FindSessionUsecase {
    func execute() async throws -> User?
}

final class FindSessionUsecaseImpl: FindSessionUsecase {
    let repository: AuthSessionRepository

    init(repository: AuthSessionRepository) {
        self.repository = repository
    }

    func execute() async throws -> User? {
        try await self.repository.find()
    }
}
