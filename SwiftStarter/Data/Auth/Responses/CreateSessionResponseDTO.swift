//
//  CreateSessionResponseDTO.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

nonisolated struct CreateSessionResponseDTO: Decodable {
    let firstName: String
    let lastName: String
    let accessToken: String
    let refreshToken: String

    func toDomain() -> AuthSession {
        .init(
            firstName: firstName,
            lastName: lastName,
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }

}
