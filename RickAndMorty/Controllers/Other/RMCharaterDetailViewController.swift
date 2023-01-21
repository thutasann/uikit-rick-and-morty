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
    private let detailView = RMCharacterDetailView();

    // MARK: Initialization (View Model)
    init(viewModel : RMCharacterDetailViewViewModel ){
        self.viewModel = viewModel;
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
