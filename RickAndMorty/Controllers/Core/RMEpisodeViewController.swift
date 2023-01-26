//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/29/22.
//

import UIKit

final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {
    
    private let episodeListView = RMEpisodeListView();

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Episodes";
        setupView();
    }
    
    // MARK: Setup View
    private func setupView(){
        episodeListView.delegate = self;
        view.addSubview(episodeListView);
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]);
    }
    
    // MARK: Delegate Function
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        // Open Detail Controller for that Episode
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url));
        detailVC.navigationItem.largeTitleDisplayMode = .never;
        navigationController?.pushViewController(detailVC, animated: true);
    }
    
    

}
