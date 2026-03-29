//
//  Endpoint.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/20/26.
//

import Alamofire
import Foundation

/// Describes the full contract of a single API request.
/// Concrete endpoint enums conform to this protocol.
protocol Endpoint {

    /// Path appended to the base URL. Must begin with "/".
    var path: String { get }

    /// HTTP method for this request.
    var method: HTTPMethod { get }

    /// URL query params or request body params, encoded via `encoding`.
    var parameters: Parameters? { get }

    /// Strategy for encoding `parameters` into the request.
    var encoding: ParameterEncoding { get }

    /// Additional headers merged with the session's default headers.
    var headers: HTTPHeaders? { get }

    var body: Encodable? { get }
}

extension Endpoint {
    // Sensible defaults — override only when needed.
    var parameters: Parameters? { nil }
    var headers: HTTPHeaders? { nil }
    var encoding: ParameterEncoding { URLEncoding.default }
}
