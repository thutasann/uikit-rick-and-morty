//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/29/22.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground;
        title = "Characters"
        
        // MARK: API Request
        let request = RMRequest(
            endpoint: .character,
            queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive")
            ]
        );
        
        
        // MARK: Execute Function
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
        
        }
    }

}
