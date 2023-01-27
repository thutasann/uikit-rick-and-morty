//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 26/01/2023.
//

import UIKit

protocol RMEpisodeListViewDelegate: AnyObject{
    func rmEpisodeListView(
        _ episodeListView: RMEpisodeListView,
        didSelectEpisode episode: RMEpisode
    )
}

/// Episode List View that handless Episdoes, Spinner
final class RMEpisodeListView: UIView{
    
    public weak var delegate: RMEpisodeListViewDelegate?;
    private let viewModel = RMEpisodeListViewViewModel();
    
    // MARK: Spinner
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large);
        spinner.hidesWhenStopped = true;
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        return spinner;
    }();
    
    // MARK: CollectionView
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10);
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.isHidden = true;
        collectionView.alpha = 0;
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(RMCharacterEpisodesCollectionViewCell.self , forCellWithReuseIdentifier: RMCharacterEpisodesCollectionViewCell.cellIdentifier);
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier) // Register with Pagination Indicator
            return collectionView;
    }();
    
    // MARK: Initialization
    override init(frame: CGRect){
        super.init(frame: frame);
        translatesAutoresizingMaskIntoConstraints = false;
        addSubviews(collectionView, spinner);
        addConstraints();
        spinner.startAnimating();
        viewModel.delegate = self;
        viewModel.fetchEpisodes();
        setupCollectionView();
    }
    required init?(coder: NSCoder){
        fatalError("Unsupported");
    }
    
    // MARK: Add Constraint
    private func addConstraints(){
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]);
    }
    
    // MARK: SetUp Collection View
    private func setupCollectionView(){
        collectionView.dataSource = viewModel;
        collectionView.delegate = viewModel;
    }
    
}

// MARK: Episode List View VieModel Delegate
extension RMEpisodeListView : RMEpisodeListViewViewModelDelegate{
    
    // Did Select Episode
    func didSelectEpisode(_ episode: RMEpisode) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
    }
    
    // Did Load Initial Episodes
    func didLoadInitialEpisodes() {
        spinner.stopAnimating();
        collectionView.isHidden = false;
        collectionView.reloadData(); // Initial Fetch Data
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1;
        }
    }
    
    // Did Load More Characters
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths);
        }
    }
    
}
