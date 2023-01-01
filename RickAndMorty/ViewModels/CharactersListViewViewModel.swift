//
//  CharactersListViewViewModel.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import Foundation
import UIKit

protocol CharactersListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

/// View Model For Character List View
final class CharactersListViewViewModel : NSObject {
    
    public weak var delegate: CharactersListViewViewModelDelegate?
    
    private var characters : [RMCharacter] = []{
        didSet{
            for character in characters{
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                );
                cellViewModels.append(viewModel);
            }
        }
    };
    
    private var cellViewModels : [RMCharacterCollectionViewCellViewModel] = [];
    
    // MARK: FETCH CHARACTERS FUNCTION
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequests,
            expecting: RMGetAllCharactersResponse.self
    ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results;
                self?.characters = results;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}


extension CharactersListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
   
    // MARK: Number of Items In section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count;
    }
    
    // MARK: Cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else{
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
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
