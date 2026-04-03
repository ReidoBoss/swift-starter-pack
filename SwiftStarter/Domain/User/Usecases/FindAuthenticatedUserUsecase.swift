//
//  FindAuthenticatedUserUsecase.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

protocol FindAuthenticatedUserUsecase {
    func execute() async throws
}

final class FindAuthenticatedUserImpl: FindAuthenticatedUserUsecase {

    let repository: AuthSessionRepository
    let userStorage: UserStorage

    init(
        repository: AuthSessionRepository,
        userStorage: UserStorage
    ) {
        self.repository = repository
        self.userStorage = userStorage
    }

    func execute() async throws {
        let user = try await repository.find()
        if let user {
            userStorage.save(user: user)
        }
    }
}
