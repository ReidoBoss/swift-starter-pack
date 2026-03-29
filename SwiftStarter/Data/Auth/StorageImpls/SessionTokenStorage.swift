//
//  SessionTokenStorage.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation
import Valet

final class SessionTokenStorage: TokenStorage {

    // MARK: - Properties

    private let valet: Valet

    private let key: String

    // MARK: - Init

    init(
        identifier: Identifier,
        accessibility: Accessibility = .whenUnlocked,
        key: String
    ) {
        self.valet = Valet.valet(
            with: identifier,
            accessibility: accessibility
        )
        self.key = key
    }

    func save(token: String) throws {
        try valet.setString(token, forKey: key)
    }

    func get() throws -> String? {
        try valet.string(forKey: key)
    }

    func delete() throws {
        try valet.removeObject(forKey: key)
    }
}
