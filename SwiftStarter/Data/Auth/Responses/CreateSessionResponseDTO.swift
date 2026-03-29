//
//  CreateSessionResponseDTO.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Foundation

nonisolated struct CreateSessionResponseDTO: Decodable {

    let accessToken: String
    let refreshToken: String

    func toDomain() -> AuthSession {
        .init(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }

}
