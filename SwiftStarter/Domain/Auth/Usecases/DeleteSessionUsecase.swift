//
//  DeleteSessionUsecase.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Foundation

protocol DeleteSessionUsecase {
    func execute() async throws
}

final class DeleteSessionImpl: DeleteSessionUsecase {

    let authTokenStorage: AuthTokenStorage
    let userStorage: UserStorage

    init(
        authTokenStorage: AuthTokenStorage,
        userStorage: UserStorage
    ) {
        self.authTokenStorage = authTokenStorage
        self.userStorage = userStorage
    }

    func execute() async throws {
        try authTokenStorage.clear()
        userStorage.clear()
    }
}
