//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 22/01/2023.
//

import UIKit

final class RMCharacterEpisodesCollectionViewCell: UICollectionViewCell {
    
    // MARK: Cell Identifier
    static let cellIdentifier = "RMCharacterEpisodesCollectionViewCell";
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame);
        contentView.backgroundColor = .systemBlue;
        contentView.layer.cornerRadius = 8;
    }
    required init?(coder: NSCoder) {
        fatalError("Not supported");
    }
    
    // MARK: Setup Constraints
    private func setupConstraints(){
        
    }
    
    // MARK: Prepare For Reuse
    override func prepareForReuse() {
        
    }
    
    // MARK: CONFIGURE THE COLLECTION VIEW CELL
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel){
        viewModel.registerForData { data in
            print(String(describing: data))
        }
        viewModel.fetchEpisodes();
    }
    
    
}
 
