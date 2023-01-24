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
    
    // MARK: Value Label
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Earth";
        label.font = .systemFont(ofSize: 22, weight: .light);
        return label;
    }()
    
    // MARK: Title Label
    private let titleLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints  = false;
        label.text = "Location";
        label.textAlignment = .center;
        label.font = .systemFont(ofSize: 20, weight: .medium);
        return label;
    }()
    
    // MARK: Icon Image View
    private let iconImageView : UIImageView = {
        let icon = UIImageView();
        icon.translatesAutoresizingMaskIntoConstraints = false;
        icon.image = UIImage(systemName: "globe.americas")
        icon.contentMode = .scaleAspectFit;
        return icon;
    }()
    
    // MARK: Title Container View
    private let titleContainerView: UIView = {
        let titleView = UIView();
        titleView.translatesAutoresizingMaskIntoConstraints = false;
        titleView.backgroundColor = .secondarySystemBackground;
        return titleView;
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground;
        contentView.layer.cornerRadius = 8;
        contentView.layer.masksToBounds = true;
        contentView.addSubviews(titleContainerView, valueLabel, iconImageView);
        titleContainerView.addSubviews(titleLabel);
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Not supported");
    }
    
    // MARK: Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse();
        //valueLabel.text = nil;
        //titleLabel.text = nil;
        //iconImageView.image = nil;
    }
    
    // MARK: Setup Constraints
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        
            
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            valueLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    // MARK: CONFIGURE THE COLLECTION VIEW CELL
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel){
        
    }
    
}
