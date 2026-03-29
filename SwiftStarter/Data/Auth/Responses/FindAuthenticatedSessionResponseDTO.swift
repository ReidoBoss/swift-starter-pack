//
//  FindAuthenticatedSessionResponseDTO.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

nonisolated struct FindAuthenticatedSessionResponseDTO: Decodable {
    let firstName: String
    let lastName: String

    func toDomain() -> User {
        .init(firstName: firstName, lastName: lastName)
    }
}
