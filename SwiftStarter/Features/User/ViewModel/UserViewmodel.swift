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
    private let userService: UserServiceProtocol

    // MARK: - Init
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func loadUser(id: String) async {
        isLoading = true
        errorMessage = nil
        do {
            currentUser = try await userService.fetchProfile(id: id)
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = "An unexpected error occurred."
        }
        isLoading = false
    }

}
