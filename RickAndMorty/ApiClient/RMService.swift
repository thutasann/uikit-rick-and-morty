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
    
    /// Cache Manager
    private let cacheManager = RMAPICacheManager();
    
    /// Service Error
    enum RMServiceError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Private Constructor
    private init() {}
    
    // MARK: URL Request
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url);
        request.httpMethod = rmRequest.httpMethod;
        return request;
    }

    /// Send Rick and Morty API Call
    /// - parameters:
    /// - request: RMRequest
    /// - type : The type of object we expect to get back
    /// - completion : Callback with Data or Error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping(Result<T, Error>)-> Void
    ){
        
        // --- MARK: Cached Data
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url){
            print("Using cached API Response...🚀 ")
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData);
                completion(.success(result))
            } catch{
                completion(.failure(error))
            }
            return
        }
       
        // --- MARK: URL Request
        guard let urlRequest = self.request(from: request) else{
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        // --- MARK: URL Request Task
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            // Decode Response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                
                // Set Cache
                self?.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data
                )
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume();
    }
    
    
    
    
}
