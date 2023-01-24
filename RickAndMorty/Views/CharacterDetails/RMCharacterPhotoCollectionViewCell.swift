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
    
    // MARK: Image View
    private let imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
    }();
    
    // MARK: Initialization
    override init(frame: CGRect){
        super.init(frame: frame);
        contentView.addSubview(imageView);
        setUpConstraints();
    }
    
    required init?(coder: NSCoder){
        fatalError("Not supported");
    }
    
    // MARK: SetUp Constraints
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: Prepare For Resuse
    override func prepareForReuse() {
        super.prepareForReuse();
        imageView.image = nil;
    }
    
    // MARK: CONFIGURE THE COLLECTION VIEW CELL
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure:
                break;
            }
        }
    }
    
    
}
