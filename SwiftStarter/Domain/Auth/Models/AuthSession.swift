//
//  AuthSession.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

struct AuthSession {
    let firstName: String
    let lastName: String
    let accessToken: String
    let refreshToken: String

    func toUser() -> User {
        .init(firstName: firstName, lastName: lastName)
    }
}
