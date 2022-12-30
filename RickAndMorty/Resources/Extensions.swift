//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/30/22.
//

import UIKit

extension UIView{
    
    // MARK: - Add Sub View Custom Extensions
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
    
}
