//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 25/01/2023.
//

import UIKit

class RMEpisodeDetailViewViewModel {

    private let endpointURL: URL?
    
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
        fetchEpisodeData();
    }
    
    // MARK: Fetch Episode Data
    private func fetchEpisodeData(){
        
        guard let url = endpointURL,
              let request = RMRequest(url: url) else{
            return;
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(failure);
                break;
            }
        }
    }
}
