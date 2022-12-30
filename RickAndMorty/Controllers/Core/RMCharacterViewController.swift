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
        
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total ", String(model.info.count))
                print("Page Result Count", String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

}
