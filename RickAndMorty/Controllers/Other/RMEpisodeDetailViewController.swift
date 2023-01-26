//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 25/01/2023.
//

import UIKit

/// SIngle Episode Detial View
final class RMEpisodeDetailViewController: UIViewController {

    // MARK: ViewModel
    private let viewModel: RMEpisodeDetailViewViewModel;
    
    // MARK: Initialization
    init(url: URL?){
        self.viewModel = .init(endpointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad();
        title = "Episode";
        view.backgroundColor = .systemGreen;
    }

}
