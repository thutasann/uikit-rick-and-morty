//
//  RMCharacterDetailViewViewDetail.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character : RMCharacter
    
    init(character: RMCharacter){
        self.character = character;
    }

    private var requestURL : URL?{
        return URL(string: character.url)
    }
    
    public var title : String{
        character.name.uppercased();
    }
    
}
