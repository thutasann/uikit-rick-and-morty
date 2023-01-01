//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/31/22.
//

import UIKit

/// SINGLE CELL FOR A CHARACTER
final class RMCharacterCollectionViewCell: UICollectionViewCell {
 
    static let cellIdentifier = "RMCharacterCollectionViewCell";
    
    // MARK: Image View
    private let imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
    }()
    
    // MARK: Name Label
    private let nameLabel : UILabel = {
        let label = UILabel();
        label.textColor = .label;
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }()
    
    // MARK: Status Label
    private let statusLabel : UILabel = {
        let label = UILabel();
        label.textColor = .secondaryLabel;
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel);
        addConstraints()
        setUpLayer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp Layer
    private func setUpLayer(){
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor;
        contentView.layer.cornerRadius = 4;
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    
    // MARK: Add Constraints
    private func addConstraints(){
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
        ])

    }
    
    // MARK: Trait Collection Did Change
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    // MARK: Prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil;
        nameLabel.text = nil;
        statusLabel.text = nil;
    }
    
    // MARK: Configuration
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel){
        nameLabel.text = viewModel.characterName;
        statusLabel.text = viewModel.characterStatusText;
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image;
                }
            case .failure(let error):
                print(String(describing: error))
                break;
            }
        }
    }
    
}
