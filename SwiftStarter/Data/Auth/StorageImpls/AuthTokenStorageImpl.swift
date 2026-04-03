//
//  AuthTokenStorageImpl.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation
import Valet

final class AuthTokenStorageImpl: AuthTokenStorage {

    // MARK: - Properties

    private let valet: Valet

    // MARK: - Init

    init(
        identifier: Identifier,
        accessibility: Accessibility = .whenUnlocked,
    ) {
        self.valet = Valet.valet(
            with: identifier,
            accessibility: accessibility
        )
    }

    func save(token: String, type: TokenType) throws {
        try valet.setString(token, forKey: type.rawValue)
    }

    func get(type: TokenType) throws -> String? {
        try valet.string(forKey: type.rawValue)
    }

    func delete(type: TokenType) throws {
        try valet.removeObject(forKey: type.rawValue)
    }

    func clear() throws {
        try valet.removeAllObjects()
    }
}
