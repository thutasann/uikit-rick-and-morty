//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 22/01/2023.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
        
    // MARK: Cell Identifier
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell";
    
    // MARK: Initialization
    override init(frame: CGRect){
        super.init(frame: frame);
    }
    required init?(coder: NSCoder){
        fatalError("Not supported");
    }
    
    // MARK: SetUp Constraints
    private func setUpConstraints(){
        
    }
    
    // MARK: Prepare For Resuse
    override func prepareForReuse() {
        
    }
    
    // MARK: CONFIGURE THE COLLECTION VIEW CELL
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel){
        
    }
    
    
}
