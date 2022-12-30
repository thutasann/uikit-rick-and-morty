//
//  RMGetAllCharacterResponse.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    
    struct Info : Codable{
        let count : Int
        let pages: Int
        let next: String?
        let prev : String?
    }
    
    let info: Info
    let results: [RMCharacter]
    
}
