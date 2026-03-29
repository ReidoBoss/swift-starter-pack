//
//  CreateSessionInput.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

struct CreateSessionInput {
    let username: String
    let password: String
    func toDTO() -> CreateSessionRequestDTO {
        .init(username: username, password: password)
    }
}
