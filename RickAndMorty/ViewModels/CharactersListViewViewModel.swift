//
//  CharactersListViewViewModel.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import Foundation
import UIKit

/// View Model For Character List View
final class CharactersListViewViewModel : NSObject {
    
    // MARK: Fetch Characters
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total ", String(model.info.count))
                print("Page Result Count", String(model.results.count))
                print("Image", String(model.results.first?.image ?? "NO Image"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}


extension CharactersListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
   
    // MARK: Number of Items In section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    // MARK: Cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else{
            fatalError("Unsupported cell")
        }
        
        let viewModel = RMCharacterCollectionViewCellViewModel(
                        characterName: "Afraz",
                        characterStatus: .alive,
                        characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        );
        cell.configure(with: viewModel)
        return cell;
    }
    
    // MARK: Size For Item At (Grid columns)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds;
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
}
