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
    
    /// Service Error
    enum RMServiceError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Private Constructor
    private init() {}

    /// Send Rick and Morty API Call
    /// - parameters:
    /// - type : The type of object we expect to get back
    /// - completion : Callback with Data or Error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping(Result<T, Error>)-> Void
    ){
        // urlRequest
        guard let urlRequest = self.request(from: request) else{
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume();
    }
    
    
    // MARK: Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url);
        request.httpMethod = rmRequest.httpMethod;
        return request;
    }
    
}
