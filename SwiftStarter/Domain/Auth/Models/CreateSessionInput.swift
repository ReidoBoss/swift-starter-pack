//
//  CreateSessionInput.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

struct CreateSessionInput {
    let email: String
    let password: String
    func toDTO() -> CreateSessionRequestDTO {
        .init(email: email, password: password)
    }
}
