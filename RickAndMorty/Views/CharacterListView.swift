//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import UIKit

/// Character List View that handles Characters, Spinner, etc.
final class CharacterListView: UIView {

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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true;
        collectionView.alpha = 0;
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
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


extension CharacterListView : CharactersListViewViewModelDelegate{
    
    func didLoadInitialCharacters() {
        
        spinner.stopAnimating()
        collectionView.isHidden = false;
        collectionView.reloadData(); // Initial Fetch Data;
        UIView.animate(withDuration: 0.4){
            self.collectionView.alpha = 1;
        }
    }
}
