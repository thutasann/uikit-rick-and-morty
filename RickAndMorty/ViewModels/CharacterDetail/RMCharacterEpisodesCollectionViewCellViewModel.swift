//
//  RMCharacterEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 23/01/2023.
//
// DidSet -> runs a piece of code right after the property has changed.
// WillSet -> runs a piece of code right before a property changes.

import Foundation

protocol RMEpisodeDataRender{
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodesCollectionViewCellViewModel : Hashable, Equatable {
        
        
    private let episodeDataUrl: URL?
    private var isFetching = false;
    private var dataBlock : ((RMEpisodeDataRender) -> Void)?
    
    // MARK: Episode
    private var episode: RMEpisode?{
        didSet{
            guard let model = episode else{
                return;
            }
            dataBlock?(model)
        }
    }
    
    // MARK: Initialiaztion
    init( episodeDataUrl: URL? ){
        self.episodeDataUrl = episodeDataUrl;
    }
    
    // MARK: - Register For Data
    public func registerForData(_ block: @escaping(RMEpisodeDataRender) -> Void){
        self.dataBlock = block;
    }
    
    // MARK: - FETCH ESPIDOES
    public func fetchEpisodes(){
        guard !isFetching else{
            if let model = episode{
                dataBlock?(model)
            }
            return;
        }
        guard let url = episodeDataUrl,
              let request = RMRequest(url: url) else {
            return;
        }
        
        isFetching = true;
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model;
                }
            case .failure(let failure):
                print(String(describing: failure));
            }
        }
    }
    
    // MARK: - Hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodesCollectionViewCellViewModel, rhs: RMCharacterEpisodesCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue;
    }

    
    
}
