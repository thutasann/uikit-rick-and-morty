//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/31/22.
//

import Foundation

/// View Model for a single Character
final class RMCharacterCollectionViewCellViewModel {
    
    public  let characterName : String
    private let characterStatus : RMCharacterStatus
    private let characterImageUrl : URL?
    
    // MARK: Init
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
    
    // MARK: Fetch Image Func
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        // TODO: Abstract to Imag Manager
        
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)));
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)));
                return;
            }
            completion(.success(data))
        }
        
        task.resume();
        
    }
}
