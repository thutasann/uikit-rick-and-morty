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
    
    // MARK: Season Label
    private let seasonLabel : UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 20, weight: .semibold);
        return label;
    }()
    
    // MARK: Name Label
    private let nameLabel : UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 22, weight: .regular);
        return label;
    }()
    
    // MARK: Air Date Label
    private let airDateLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints  = false;
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label;
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame);
        contentView.backgroundColor = .systemBackground;
        contentView.layer.cornerRadius = 8;
        contentView.layer.borderWidth = 2;
        contentView.layer.borderColor = UIColor.systemBlue.cgColor;
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        setupConstraints();
    }
    required init?(coder: NSCoder) {
        fatalError("Not supported");
    }
    
    // MARK: Setup Constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
            
        ])
    }
    
    // MARK: Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse();
        seasonLabel.text = nil;
        nameLabel.text = nil;
        airDateLabel.text = nil;
    }
    
    // MARK: CONFIGURE THE COLLECTION VIEW CELL
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel){
        viewModel.registerForData { [weak self] data in
            // Main Queue
            self?.nameLabel.text = data.name;
            self?.seasonLabel.text = "Episode: "+data.episode;
            self?.airDateLabel.text = "Aired on "+data.air_date;
        }
        viewModel.fetchEpisodes();
    }
    
    
}
 
