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

    // MARK: - Properties

    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private let createSessionUsecase: CreateSessionUsecase

    // MARK: - Init

    init(createSessionUsecase: CreateSessionUsecase) {
        self.createSessionUsecase = createSessionUsecase
    }

    // MARK: - Actions

    func create(email: String, password: String) {
        guard !isLoading else { return }

        Task { [weak self] in
            guard let self else { return }

            isLoading = true
            errorMessage = nil

            let input = CreateSessionInput(
                email: email,
                password: password
            )

            do {
                try await createSessionUsecase.execute(input)
            } catch let error as AuthError {
                errorMessage = error.errorDescription
            } catch {
                errorMessage = String(localized: "error.generic")

            }

            isLoading = false
        }
    }
}
