//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 26/01/2023.
//

import Foundation
import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

/// View Model to Handle the Episode List VIew Logic
final class RMEpisodeListViewViewModel: NSObject{
    
    // MARK: Delegate
    public weak var delegate: RMEpisodeListViewViewModelDelegate?;
    
    // MARK: Is Loading More Characters
    private var isLoadingMoreEpisodes : Bool = false;
    
    // MARK: Character Collection ViewCell ViewModel
    private var cellViewModels: [RMCharacterEpisodesCollectionViewCellViewModel] = [];
    
    // MARK: API Response Info
    private var apiInfo : RMGetAllEpisodesResponse.Info? = nil;
    
    // MARK: Computed Episodes
    private var episodes: [RMEpisode] = [] {
        didSet{
            for episode in episodes{
                let viewModel = RMCharacterEpisodesCollectionViewCellViewModel(episodeDataUrl: URL(string: episode.url));
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel);
                }
            }
        }
    }
    
    // MARK: Fetch Episodes (20)
    public func fetchEpisodes(){
        RMService.shared.execute(
            .listEpisodesRequests,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            switch result{
            case .success(let responseModel):
                let results = responseModel.results;
                let info = responseModel.info;
                self?.episodes = results;
                self?.apiInfo = info;
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // MARK: Paginate If Addinational Episodes are needed
    public func fetchAdditionalEpisodes(url: URL){
        guard !isLoadingMoreEpisodes else{
            return;
        }
        isLoadingMoreEpisodes = true;
        guard let request = RMRequest(url: url) else{
            isLoadingMoreEpisodes = false;
            print("Failed to create Request...")
            return;
        }
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else{
                return;
            }
            switch result {
            case .success(let responseModel) :
                print("Pre-update: \(strongSelf.cellViewModels.count)") //20
                
                let moreResults = responseModel.results;
                let info = responseModel.info;
                strongSelf.apiInfo = info;
                
                let originalCount = strongSelf.episodes.count; // 20
                let newCount = moreResults.count; // 20
                let total = originalCount + newCount; // 2
                let startingIndex = total - newCount;
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                });
                
                strongSelf.episodes.append(contentsOf: moreResults);
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathsToAdd);
                    print("Post-update: \(strongSelf.cellViewModels.count)") // 20 + 20 -> 40
                    strongSelf.isLoadingMoreEpisodes = false;
                }
                
                
            case .failure(let failure):
                print(String(describing: failure));
                self?.isLoadingMoreEpisodes = false;
            }
        }
    }
    
    // MARK: Should show Load More Indicator
    public var shouldShowLoadMoreIndicator: Bool{
        return apiInfo?.next != nil;
    }
    
}

// MARK: - RMEpisode ListView ViewModel Extension
extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // MARK: Number of Items in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count;
    }
    
    // MARK: Cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodesCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodesCollectionViewCell else{
            fatalError("Unsupported Cell")
        }
        cell.configure(with: cellViewModels[indexPath.row]);
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
    
    // MARK: Size For Item At (Grid Columns)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds;
        let width = (bounds.width - 30)/2;
        return CGSize(width: width, height: width * 0.8)
    }
    
    // MARK: Did Select Item At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true);
        let episode = episodes[indexPath.row];
        delegate?.didSelectEpisode(episode)
    }
}

// MARK: - RMEpisode List VIew ScrollView (For Pagination)
extension RMEpisodeListViewViewModel: UIScrollViewDelegate{
    
    // ScrollView Did Scrol
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreEpisodes,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else{
            return
        }
        
        // Timer
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y;
            let totalContentHeight = scrollView.contentSize.height;
            let totalScrollViewFixedHeight = scrollView.frame.size.height;
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                print("should start Fetching More...");
                self?.fetchAdditionalEpisodes(url: url)
            }
            t.invalidate()
        }
        
    }
    
}
