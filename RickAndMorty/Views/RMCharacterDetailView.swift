//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import UIKit

/// View For Single Character Info
final class RMCharacterDetailView: UIView {
    
    // MARK: Initialization
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
}
