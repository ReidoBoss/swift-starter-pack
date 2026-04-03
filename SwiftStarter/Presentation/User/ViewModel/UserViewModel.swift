//
//  UserViewModel.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Foundation
import Observation

@Observable
final class UserViewModel {
    // MARK: - Dependencies
    let userStorage: UserStorage
    let findUserUsecase: FindAuthenticatedUserUsecase
    // MARK: - Properties
    var currentUser: User? {
        userStorage.user
    }

    // MARK: - Initialization
    init(
        userStorage: UserStorage,
        findUserUsecase: FindAuthenticatedUserUsecase
    ) {
        self.userStorage = userStorage
        self.findUserUsecase = findUserUsecase
    }

    func find() {
        Task { [weak self] in
            guard let self else { return }
            try await self.findUserUsecase.execute()
        }
    }

}
