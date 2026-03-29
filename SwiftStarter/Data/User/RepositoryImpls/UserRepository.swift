//
//  UserRepository.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Foundation

protocol UserRepository {
    func fetchProfile(id: String) async throws -> User
}

final class UserRepositoryImpl: UserRepository {

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func fetchProfile(id: String) async throws -> User {
        try await userService.fetchProfile(id: id).toDomain()
    }
}
