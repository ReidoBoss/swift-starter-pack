//
//  FindUserUsecase.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Foundation

protocol FindUserUsecase {
    func execute(id: String) async throws -> User
}

struct FindUserUsecaseImpl: FindUserUsecase {
    private let userRepository: UserRepository

    func execute(id: String) async throws -> User {
        try await userRepository.fetchProfile(id: id)
    }
}
