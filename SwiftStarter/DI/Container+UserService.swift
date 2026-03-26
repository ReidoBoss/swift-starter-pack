//
//  Container+UserService.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Alamofire
import Factory
import Foundation

extension Container {
    var userService: Factory<UserServiceProtocol> {
        self { @MainActor in
            UserService(client: self.apiClient())
        }.shared
    }
}
