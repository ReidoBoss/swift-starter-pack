//
//  APIError.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/20/26.
//

import Foundation

/// Unified error type for all networking failures.
/// Callers should switch on this to present appropriate UI feedback.
enum APIError: Error, LocalizedError {

    /// The server returned a non-2xx HTTP status code.
    case httpError(statusCode: Int, data: Data?)

    /// Response data could not be decoded into the expected model.
    case decodingFailed(underlying: Error)

    /// The request could not be constructed or the network was unreachable.
    case requestFailed(underlying: Error)

    /// A response was received but the body was empty when data was expected.
    case emptyResponse

    /// A response was received but the body was empty when data was expected.
    case sessionExpired

    var errorDescription: String? {
        switch self {
        case .httpError(let code, _):
            return "Server returned an error (HTTP \(code))."
        case .decodingFailed:
            return "The response could not be read. Please try again."
        case .requestFailed:
            return "The request failed. Check your connection."
        case .emptyResponse:
            return "No data was returned from the server."
        case .sessionExpired:
            return "Your session has expired. Please log in again."
        }
    }
}
