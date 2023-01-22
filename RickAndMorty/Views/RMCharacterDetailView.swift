//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import UIKit

/// View For Single Character Info
final class RMCharacterDetailView: UIView {
    
    public var collectionView : UICollectionView?
    private let viewModel : RMCharacterDetailViewViewModel
    
    // MARK: Spinner
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true;
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        return spinner;
    }();
    
    // MARK: Initialization
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        backgroundColor = .systemBackground
        let collectionView = createCollectionView();
        self.collectionView = collectionView;
        addSubviews(collectionView, spinner)
        addConstraints();
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: Constraints
    private func addConstraints(){
        guard let collectionView = collectionView else {
            return
        }
        
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
    
    // MARK: Create UICOllectionView
    private func createCollectionView() -> UICollectionView{
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        return collectionView;
    }
    
    // MARK: Create Section
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection{
        
        let sectionTypes = viewModel.sections;
        
        switch sectionTypes[sectionIndex]{
            case .photo:
                return viewModel.createPhotoSectionLayout()
            case .information:
                return viewModel.createInformationSectionLayout()
            case .episodes:
                return viewModel.createEpisodesSectionLayout()
        }
    }
    
    
 
}
