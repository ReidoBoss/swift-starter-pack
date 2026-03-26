//
//  UserService.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/26/26.
//

// MARK: - Protocol

protocol UserServiceProtocol {
    func fetchProfile(id: String) async throws -> User
}

// MARK: - Implementation

final class UserService: UserServiceProtocol {

    // MARK: - Dependencies

    private let client: APIClientProtocol

    // MARK: - Init

    init(client: APIClientProtocol) {
        self.client = client
    }

    // MARK: - ExampleModelServiceProtocol

    func fetchProfile(id: String) async throws -> User {
        try await client.request(
            UserEndpoint.fetchProfile(id: id),
            as: User.self
        )
    }
}
