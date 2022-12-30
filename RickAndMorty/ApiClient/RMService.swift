//
//  RMService.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/29/22.
//

import Foundation

/// Primary API service object to get Data
final class RMService{
    
    /// Shared Singleton Instanace
    static let shared = RMService();
    
    /// Private Constructor
    private init() {}

    /// Send Rick and Morty API Call
    /// - Parameters:
    /// - request : Request Instance
    /// - completion : Callback with Data or Error
    public func execute(_ request: RMRequest, completion: @escaping() -> Void){
        
    }
}
