//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 26/01/2023.
//

import Foundation

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

/// View Model to Handle the Episode List VIew Logic
final class RMCharacterListViewViewModel: NSObject{
    
    // Delegate
    public weak var delegate: RMEpisodeListViewViewModelDelegate?;
    
    // Is Loading More Characters
    private var isLoadingMoreEpisodes : Bool = false;
    
    // Character Collection ViewCell ViewModel
    private var cellViewModels: [RMCharacterEpisodesCollectionViewCellViewModel] = [];
    
    // API Response Info
    private var apiInfo : RMGetAllCharactersResponse.Info? = nil;
    
    // Episodes
    private var episodes: [RMEpisode] = [] {
        didSet{
            for episode in episodes{
                print("OK", episode)
            }
        }
    }
    
    
}
