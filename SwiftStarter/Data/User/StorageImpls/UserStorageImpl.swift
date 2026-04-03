//
//  UserStorageImpl.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Foundation
import Observation

@Observable
final class UserStorageImpl: UserStorage {
    private(set) var user: User?

    func save(user: User) {
        self.user = user
    }

    func clear() {
        self.user = nil
    }

}
