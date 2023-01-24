//
//  RMCharaterDetailViewController.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import UIKit

/// Single Character Detail Controller
final class RMCharaterDetailViewController: UIViewController {
    
    private let viewModel : RMCharacterDetailViewViewModel;
    private let detailView: RMCharacterDetailView;

    // MARK: Initialization (View Model)
    init(viewModel : RMCharacterDetailViewViewModel ){
        self.viewModel = viewModel;
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder){
        fatalError("Unsupported")
    }
    
    // MARK: View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title;
        view.addSubviews(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        addConstraints();
        
        detailView.collectionView?.delegate = self;
        detailView.collectionView?.dataSource = self;
    }

    
    // MARK: Did Tap Share
    @objc func didTapShare(){
        // Share character info
    }
    
    // MARK: Add Constraints
    private func addConstraints(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - RMCharacterDetailViewController Extension
extension RMCharaterDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: Number of Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count;
    }
    
    // MARK: Number Of Item in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section];
        switch sectionType {
        case .photo:
            return 1;
        case .information(let viewModels):
            return viewModels.count;
        case .episodes(let viewModels) :
            return viewModels.count;
        }
    }
    
    // MARK: Cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Seciton Type
        let sectionType = viewModel.sections[indexPath.section];
        
        // Section Type Switch Case
        switch sectionType{
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.backgroundColor = .systemRed;
            cell.configure(with: viewModel);
            return cell;
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell;
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodesCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterEpisodesCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell;
        }
        
    }
    
    
}
