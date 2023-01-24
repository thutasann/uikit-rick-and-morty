//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 23/01/2023.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel{
    
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    // MARK: Fetch Image
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let imageUrl = imageUrl else{
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
