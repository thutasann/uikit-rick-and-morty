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

// MARK: - RMCharacterDetailViewController Delegate
extension RMCharaterDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: Number of Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count;
    }
    
    // MARK: Number Of Item in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 1
        }
    }
    
    // MARK: Cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink;
        } else if indexPath.section == 1{
            cell.backgroundColor = .systemGreen;
        } else {
            cell.backgroundColor = .systemRed;
        }
        
        return cell;
    }
    
    
}
