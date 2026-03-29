//
//  CreateSessionResponseDTO.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

nonisolated struct CreateSessionResponseDTO: Decodable {

    let token: String

    func toDomain() -> AuthSession {
        .init(token: token)
    }
}
