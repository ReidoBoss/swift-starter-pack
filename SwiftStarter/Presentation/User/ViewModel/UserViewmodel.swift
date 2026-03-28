//
//  UserViewmodel.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Observation

@Observable
final class UserViewmodel {
    // MARK: - Properties
    private(set) var currentUser: User?
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    // MARK: - Dependencies
    private let findUserUsecase: FindUserUsecase

    // MARK: - Init
    init(findUserUsecase: FindUserUsecase) {
        self.findUserUsecase = findUserUsecase
    }

    // MARK: - Methods
    func loadUser(id: String) async {
        isLoading = true
        errorMessage = nil
        do {
            currentUser =
                try await findUserUsecase
                .execute(id: id)
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = "An unexpected error occurred."
        }
        isLoading = false
    }

}
