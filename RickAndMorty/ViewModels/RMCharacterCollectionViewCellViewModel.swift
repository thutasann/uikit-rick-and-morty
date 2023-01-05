//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/31/22.
//

import Foundation

/// View Model for a single Character
final class RMCharacterCollectionViewCellViewModel : Hashable, Equatable {
    
    public  let characterName : String
    private let characterStatus : RMCharacterStatus
    private let characterImageUrl : URL?
    
    // MARK: - Init
    init(
        characterName : String,
        characterStatus: RMCharacterStatus,
        characterImageUrl : URL?
    ){
        self.characterName = characterName;
        self.characterStatus = characterStatus;
        self.characterImageUrl = characterImageUrl;
    }
    
    public var characterStatusText : String {
        return "Status: \(characterStatus.text)"
    }
    
    // MARK: - Fetch Image Function
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)));
            return
        }
        RMImageLoader.shared.downloadImage(url, completion: completion);
    }
    
    // MARK: - Hashable
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
