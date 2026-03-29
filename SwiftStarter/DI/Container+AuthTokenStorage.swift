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

    var authTokenStorage: Factory<AuthTokenStorage> {
        self { @MainActor in
            AuthTokenStorageImpl(
                identifier: .init(nonEmpty: "authTokenStorage")!
            )
        }.shared
    }
}
