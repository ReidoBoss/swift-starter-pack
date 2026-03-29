//
//  CreateSessionRequestDTO.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

struct CreateSessionRequestDTO: Encodable {
    let email: String
    let password: String
}
