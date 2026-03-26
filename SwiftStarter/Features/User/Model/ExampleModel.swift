//
//  ExampleModel.swift
//  AsaTa
//
//  Created by Stephen Sagarino on 3/27/26.
//

import Foundation

/// Decoded response model for a single Youth Profile record.
nonisolated struct ExampleModel: Decodable, Identifiable {
    let id: String
    let fullName: String

}
