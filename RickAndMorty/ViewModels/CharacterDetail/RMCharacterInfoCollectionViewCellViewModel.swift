//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 23/01/2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let type: `Type`;
    private let value: String;
    
    // MARK: Date Formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ";
        formatter.timeZone = .current;
        return formatter;
    }()
    
    // MARK: Short Date Formatter
    static let ShortDateFormatter : DateFormatter = {
        let formatter = DateFormatter();
        formatter.dateStyle = .medium;
        formatter.timeStyle = .short;
        formatter.timeZone = .current;
        return formatter;
    }()

    // MARK: Computed Title
    public var title: String{
        type.displayTitle
    }
    
    // MARK: Computed Display Value
    public var displayValue: String{
        if value.isEmpty { return "none" }
        
        if type == .created{
            print("format : \(value)")
        }
        
        if let date = Self.dateFormatter.date(from: value), type == .created{
            return Self.ShortDateFormatter.string(from: date)
        }
        
        return value;
    }
    
    // MARK: Computed Icon Image
    public var iconIMage: UIImage?{
        return type.iconImage;
    }
    
    // MARK: Computed Tint Color
    public var tintColor: UIColor{
        return type.tintColor;
    }
    
    
    // MARK: Type Enums
    enum `Type` : String{
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        // Tint Color
        var tintColor: UIColor{
            switch self{
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemOrange
            case .location:
                return .systemPink
            case .episodeCount:
                return .systemYellow
            }
        }
        
        // Icon Image
        var iconImage: UIImage?{
            switch self{
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        // Display Titke
        var displayTitle: String{
            switch self{
            case .status,
                .gender,
                .type,
                .species,
                .origin,
                .created,
                .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "Episodes"
            }
        }
    }
    
    // MARK: Initialization
    init(type: `Type`, value: String){
        self.value = value;
        self.type  = type;
    }
    
}
