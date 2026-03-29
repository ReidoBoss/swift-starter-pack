//
//  UserResponseDTO.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/28/26.
//

import Foundation

nonisolated struct UserResponseDTO: Decodable {
    let id: String
    let fullName: String

    func toDomain() -> User {
        User(id: id, fullName: fullName)
    }
}
