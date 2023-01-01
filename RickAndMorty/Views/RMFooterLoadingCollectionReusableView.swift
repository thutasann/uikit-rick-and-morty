//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "RMFooterLoadingCollectionReusableView";
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue;
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: Add Contstraints
    private func addConstraints(){
        
    }
}
