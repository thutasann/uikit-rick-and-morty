//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import Foundation

/// Represents unique API Endpoints
@frozen enum RMEndpoint : String, CaseIterable, Hashable {
    case character
    case location
    case episode
}
