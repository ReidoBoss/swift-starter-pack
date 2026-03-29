//
//  Container+AuthTokenStorage.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Factory
import Foundation
import Valet

extension Container {

    var authTokenStorage: Factory<TokenStorage> {
        self { @MainActor in
            SessionTokenStorage(
                identifier: .init(nonEmpty: "authTokenStorage")!,
                key: "authAccessToken"
            )
        }.shared
    }
}
