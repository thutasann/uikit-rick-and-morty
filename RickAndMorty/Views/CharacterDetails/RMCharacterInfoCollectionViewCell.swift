//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 22/01/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Identifier
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell";
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("Not supported");
    }
    
    // MARK: Setup Constraints
    private func setUpConstraints(){
        
    }
    
    // MARK: Prepare For Reuse
    override func prepareForReuse() {
        
    }
    
    // MARK: CONFIGURE THE COLLECTION VIEW CELL
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel){
        
    }
    
}
