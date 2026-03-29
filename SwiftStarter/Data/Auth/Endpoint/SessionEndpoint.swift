//
//  SessionEndpoint.swift
//  SwiftStarter
//
//  Created by Stephen Sagarino on 3/29/26.
//

import Alamofire
import Foundation

enum SessionEndpoint: Endpoint {
    case create(request: CreateSessionRequestDTO)

    var path: String {
        switch self {
        case .create: return "/sessions"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .create: .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case .create:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .create: URLEncoding.default
        }
    }
}
