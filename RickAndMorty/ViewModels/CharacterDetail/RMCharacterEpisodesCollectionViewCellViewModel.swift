//
//  RMCharacterEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 23/01/2023.
//

import Foundation

final class RMCharacterEpisodesCollectionViewCellViewModel {
        
    private let episodeDataUrl: URL?
    
    init(
        episodeDataUrl: URL?
    ){
        self.episodeDataUrl = episodeDataUrl;
    }
}