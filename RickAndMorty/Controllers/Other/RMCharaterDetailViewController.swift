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
    }

}
