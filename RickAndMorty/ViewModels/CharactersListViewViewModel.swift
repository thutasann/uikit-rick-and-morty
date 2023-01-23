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
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
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
    
    // API Response Info
    private var apiInfo : RMGetAllCharactersResponse.Info? = nil;
    
    // Characters
    private var characters : [RMCharacter] = []{
        didSet{
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                );
                if !cellViewModels.contains(viewModel){ // To Prevent Duplication in paginated Characters
                    cellViewModels.append(viewModel);
                }
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
    
    // MARK: PAGINATE MORE CHARACTERS
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true;
        guard let request = RMRequest(url: url) else{
            isLoadingMoreCharacters = false;
            print("Failed to create request")
            return;
        }
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result{
            case .success(let responseModel):
                
                print("Pre-update : \(strongSelf.cellViewModels.count)") // 20
                
                let moreResults = responseModel.results;
                let info = responseModel.info;
                strongSelf.apiInfo = info;
                
                let originalCount = strongSelf.characters.count; // 20
                let newCount = moreResults.count; // 20
                let total = originalCount+newCount; // 20 + 20
                let startingIndex = total - newCount;
                let indexPathsToAdd : [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                strongSelf.characters.append(contentsOf: moreResults);
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    print("Post-update : \(strongSelf.cellViewModels.count)") //  20 + 20 -> 40
                    strongSelf.isLoadingMoreCharacters = false;
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false;
            }
        }
    }
    
    // MARK: Should Show Load More Indicator
    public var shouldShowLoadMoreIndicator : Bool{
        return apiInfo?.next != nil;
    }
    
}

// MARK: - RMCharacter List View ViewModel Extension
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
        
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else{
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in // Timer
            let offset = scrollView.contentOffset.y;
            let totalContentHeight = scrollView.contentSize.height;
            let totalScrollViewFixedHeight = scrollView.frame.size.height;
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                print("Should start Fetching More...")
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
        
        
    }
    
}
