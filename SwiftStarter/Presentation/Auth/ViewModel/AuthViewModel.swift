//
//  AuthViewModel.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation
import Observation

@Observable
final class AuthViewModel {
    // MARK: - Properties
    private let createSessionUsecase: CreateSessionUsecase

    // MARK: - init
    init(createSessionUsecase: CreateSessionUsecase) {
        self.createSessionUsecase = createSessionUsecase
    }

    // MARK: - Actions

    func login(email: String, password: String) {
        Task { [weak self] in
            guard let self else { return }

            let input = CreateSessionInput(
                email: email,
                password: password
            )

            do {
                try await createSessionUsecase.execute(input)
            } catch _ as AuthError {
                // TBD
            } catch {
                // TBD
            }
        }

    }
}
