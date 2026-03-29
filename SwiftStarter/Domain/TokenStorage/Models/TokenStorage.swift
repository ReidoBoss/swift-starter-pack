//
//  TokenStorage.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

protocol TokenStorage {
    func save(token: String) throws
    func get() throws -> String?
    func delete() throws
}
