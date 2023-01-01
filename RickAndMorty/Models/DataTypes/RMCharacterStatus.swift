//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import Foundation

enum RMCharacterStatus : String, Codable {
    
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    // Computed Text
    var text: String{
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
    
}
