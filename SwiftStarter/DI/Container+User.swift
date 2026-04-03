//
//  Container+User.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Factory
import Foundation

extension Container {
    var userStorage: Factory<UserStorage> {
        self { @MainActor in
            UserStorageImpl()
        }.shared
    }

    var findAuthenticatedUserUsecase: Factory<FindAuthenticatedUserUsecase> {
        self { @MainActor in
            FindAuthenticatedUserImpl(
                repository: self.authSessionRepository(),
                userStorage: self.userStorage()
            )
        }
    }

    var userViewModel: Factory<UserViewModel> {
        self { @MainActor in
            UserViewModel(
                userStorage: self.userStorage(),
                findUserUsecase: self.findAuthenticatedUserUsecase()
            )
        }.shared
    }

}
