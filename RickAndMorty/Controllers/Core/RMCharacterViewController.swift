//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/29/22.
//

import UIKit

final class RMCharacterViewController: UIViewController, CharacterListViewDelegate {
    
    private let characterListView = CharacterListView();

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Characters"
        setUpView()
    }
    
    // MARK: Set Up View
    private func setUpView(){
        characterListView.delegate = self;
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Character List View Delegate
    func characterListView(_ characterListView: CharacterListView, didSelectCharacter character: RMCharacter) {
        
        // Open Detail Controller For that Character
        let viewModel = RMCharacterDetailViewViewModel(character: character);
        let detailVC = RMCharaterDetailViewController(viewModel: viewModel);
        detailVC.navigationItem.largeTitleDisplayMode = .never;
        navigationController?.pushViewController(detailVC, animated: true);
        
    }

}
