//
//  SessionViewModel.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation
import Observation

@Observable
final class SessionViewModel {

    // MARK: - Dependencies
    private let createSessionUsecase: CreateSessionUsecase
    private let deleteSessionUsecase: DeleteSessionUsecase

    // MARK: - Properties
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?

    // MARK: - Init

    init(
        createSessionUsecase: CreateSessionUsecase,
        deleteSessionUsecase: DeleteSessionUsecase,
    ) {
        self.createSessionUsecase = createSessionUsecase
        self.deleteSessionUsecase = deleteSessionUsecase
    }

    // MARK: - Actions

    func create(username: String, password: String) {
        guard !isLoading else { return }
        Task { [weak self] in
            guard let self else { return }

            isLoading = true
            errorMessage = nil

            let input = CreateSessionInput(
                username: username,
                password: password
            )

            do {
                try await createSessionUsecase.execute(input)
            } catch let error as AuthError {
                errorMessage = error.errorDescription
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }

    func delete() {
        guard !isLoading else { return }
        Task { [weak self] in
            guard let self else { return }

            isLoading = true
            errorMessage = nil

            do {
                try await deleteSessionUsecase.execute()
            } catch let error as AuthError {
                errorMessage = error.errorDescription
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }
}
