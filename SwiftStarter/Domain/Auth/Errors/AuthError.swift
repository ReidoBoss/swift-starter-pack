//
//  AuthError.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

enum AuthError: Error, LocalizedError, Equatable {

    case invalidEmail
    case weakPassword

    // MARK: - LocalizedError
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return String(
                localized: "error.auth.invalidEmail",
                defaultValue: "The email address appears to be invalid."
            )
        case .weakPassword:
            return String(
                localized: "error.auth.weakPassword",
                defaultValue: "The password is too weak."
            )
        }
    }

}
