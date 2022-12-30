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
    /// - parameters:
    /// - type : The type of object we expect to get back
    /// - completion : Callback with Data or Error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping(Result<String, Error>)-> Void
    ){
        
    }
}
