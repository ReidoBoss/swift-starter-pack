//
//  TokenStorage.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

/// Identifies which token is being stored or retrieved.
enum TokenType: String {
    case access
    case refresh
}

/// Defines the contract for securely persisting authentication tokens.
protocol AuthTokenStorage: Sendable {
    /// Saves the given token string for the specified token type.
    func save(token: String, type: TokenType) throws

    /// Retrieves the stored token string for the specified token type, or nil if not found.
    func get(type: TokenType) throws -> String?

    /// Deletes the stored token for the specified token type.
    func delete(type: TokenType) throws

    /// Deletes all stored tokens. Call this on logout.
    func clear() throws
}
