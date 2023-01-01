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
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to Handle Character List View Logic
final class CharactersListViewViewModel : NSObject {
    
    // Delegate
    public weak var delegate: CharactersListViewViewModelDelegate?
    
    // Is Loading More Characters
    private var isLoadingMoreCharacters: Bool = false;
    
    // Character Collection ViewCell ViewModel
    private var cellViewModels : [RMCharacterCollectionViewCellViewModel] = [];
    
    // API Info
    private var apiInfo : RMGetAllCharactersResponse.Info? = nil;
    
    // Characters
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
    
   
    
    // MARK: FETCH CHARACTERS FUNCTION (20)
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequests,
            expecting: RMGetAllCharactersResponse.self
    ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results;
                let info = responseModel.info;
                self?.apiInfo = info;
                self?.characters = results;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // MARK: Paginate Characters
    public func fetchAdditionalCharacters() {
        isLoadingMoreCharacters = true;
        // Fetch Characters
        
    }
    
    // MARK: Should Show Load More Indicator
    public var shouldShowLoadMoreIndicator : Bool{
        return apiInfo?.next != nil;
    }
    
}

// MARK: - RMCharacter List View ViewModel
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
    
    // MARK: View For SupplementaryElementOfKind (For Footer Loading Collection Resusable View)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating();
        return footer;
    }
    
    // MARK: Reference Size For Footer In Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard shouldShowLoadMoreIndicator else {
            return .zero;
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
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
    
    // MARK: Did Select Item At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
}

// MARK: - RMCharacter List View ScrollView (FOR Pagination)
extension CharactersListViewViewModel: UIScrollViewDelegate{
    
    // Scroll View Did Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacters else{
            return
        }
        
        let offset = scrollView.contentOffset.y;
        let totalContentHeight = scrollView.contentSize.height;
        let totalScrollViewFixedHeight = scrollView.frame.size.height;
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
            print("Should start Fetching More...")
        }
        
    }
    
}
