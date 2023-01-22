//
//  RMCharacterDetailViewViewDetail.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character : RMCharacter
    
    
    // MARK: Section Type
    enum SectionType : CaseIterable{
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases;
    
    // MARK: Initialization
    init(character: RMCharacter){
        self.character = character;
    }

    // MARK: Request URL
    private var requestURL : URL?{
        return URL(string: character.url)
    }
    
    public var title : String{
        character.name.uppercased();
    }
    
}
