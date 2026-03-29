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
    case find

    var path: String {
        switch self {
        case .create: "/auth/login"
        case .find: "/auth/me"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .create: .post
        case .find: .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .create, .find:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .create, .find: URLEncoding.default
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .create, .find: nil
        }
    }

    var body: Encodable? {
        switch self {
        case .create(let request): request
        case .find: nil
        }
    }
}
