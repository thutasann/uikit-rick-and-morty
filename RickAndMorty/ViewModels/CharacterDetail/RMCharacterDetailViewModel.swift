//
//  RMCharacterDetailViewViewDetail.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/1/23.
//

import Foundation
import UIKit

final class RMCharacterDetailViewViewModel {
    
    // MARK: Variables
    private let character : RMCharacter
    

    // MARK: Section Type Enum (Photo, Info, Episodes)
    enum SectionType{
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodesCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = [];
    
    
    // MARK: Initialization
    init(character: RMCharacter){
        self.character = character;
        setUpSections();
    }
    
    // MARK: SETUP SECITONS
    private func setUpSections(){
        sections = [
            .photo(viewModel: .init()),
            .information(viewModels: [
                .init(),
                .init(),
                .init(),
                .init(),
            ]),
            .episodes(viewModels: [
                .init(),
                .init(),
                .init(),
                .init()
            ])
        ]
    }
    

    // MARK: Request URL
    private var requestURL : URL?{
        return URL(string: character.url)
    }
    
    public var title : String{
        character.name.uppercased();
    }
    
    // MARK: - LAYOUTS
    
    // MARK: Photo Section Layout
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        );
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section;
    }
    
    // MARK: Information Section layout
    public func createInformationSectionLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        );
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group);
        return section;
    }
    
    // MARK: Create Episodes Section Layout
    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8
        );
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group);
        section.orthogonalScrollingBehavior = .groupPaging;
        return section;
    }
    
}
