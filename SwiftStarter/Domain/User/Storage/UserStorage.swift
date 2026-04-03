//
//  UserStorage.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 4/3/26.
//

import Foundation

protocol UserStorage {
    var user: User? { get }

    func save(user: User)

    func clear()
}
