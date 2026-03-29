//
//  UserEndpoint.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/26/26.
//

import Alamofire
import Foundation

enum UserEndpoint: Endpoint {

    case fetchProfile(id: String)

    // MARK: - Endpoint

    var path: String {
        switch self {
        case .fetchProfile(let id): return "/users/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchProfile: return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .fetchProfile:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        default: return URLEncoding.default
        }
    }
}
