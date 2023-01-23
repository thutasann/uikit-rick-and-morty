//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import UIKit

protocol CharacterListViewDelegate : AnyObject {
    func characterListView(
        _ characterListView : CharacterListView,
        didSelectCharacter character : RMCharacter
    )
}

/// Character List View that handles Characters, Spinner, etc.
final class CharacterListView: UIView {
    
    public weak var delegate: CharacterListViewDelegate?

    private let viewModel = CharactersListViewViewModel();
    
    // MARK: SPinner
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true;
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        return spinner;
    }();
    
    // MARK: CollectionView
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true;
        collectionView.alpha = 0;
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier) // Register with CharacterCollectionViewCell
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier) // Register with Pagination Indicator
        return collectionView;
    }();
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        addSubviews(collectionView ,spinner)
        addConstraints()
        spinner.startAnimating();
        viewModel.delegate = self;
        viewModel.fetchCharacters();
        setupCollectionView();
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // Add Constraints
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
            
        ])
    }
    
    // MARK: Set Up Collection View
    private func setupCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel;
    }
}


// MARK: - Character List View ViewModel Delegate
extension CharacterListView : CharactersListViewViewModelDelegate{
    
    // Did Select Character
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.characterListView(self, didSelectCharacter: character)
    }
    

    // DID load Initial Characters
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false;
        collectionView.reloadData(); // Initial Fetch Data;
        UIView.animate(withDuration: 0.4){
            self.collectionView.alpha = 1;
        }
    }
    
    // Did Load More Characters (Patinate More Characters)
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
}
