//
//  ExampleService.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/26/26.
//

// MARK: - Protocol

protocol ExampleProfileServiceProtocol {
    func fetchProfile(id: String) async throws -> ExampleModel
}

// MARK: - Implementation

final class ExampleModelService: ExampleProfileServiceProtocol {

    // MARK: - Dependencies

    private let client: any APIClientProtocol

    // MARK: - Init

    init(client: any APIClientProtocol) {
        self.client = client
    }

    // MARK: - ExampleModelServiceProtocol

    func fetchProfile(id: String) async throws -> ExampleModel {
        try await client.request(
            ExampleEndpoint.fetchProfile(id: id),
            as: ExampleModel.self
        )
    }
}
