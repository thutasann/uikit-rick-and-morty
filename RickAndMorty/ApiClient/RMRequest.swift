//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/29/22.
//

import Foundation

/// Object that represents the single API Call
final class RMRequest {
 
    /// API constant
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired Endpoint
    let endpoint : RMEndpoint
    
    /// Path Components For API, if any
    let pathComponents: [String]

    /// Query Arguments For API, if any
    let queryParameters : [URLQueryItem]
    
    /// Constructed URL for the API request in the String Format
    private var urlString: String {
        var string = Constants.baseUrl;
        string += "/"
        string += endpoint.rawValue;
        
        if !pathComponents.isEmpty{
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty{
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)" // name=value&name=value
            }).joined(separator: "&")
            string += argumentString;
        }
        
        return string;
    }
    
    /// Computed and Constructed API URL
    public var url : URL?{
        return URL(string: urlString)
    }
    
    /// Desired HTTP Method
    public let httpMethod = "GET";
    
    
    /// CONSTRUCT REQUETS (Initialization)
    /// - Parameters:
    ///   - endpoint: Target Endpoint
    ///   - pathComponents: Collection of Path Components
    ///   - queryParameters: Collection of Query Parameters
    public init (
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ){
        self.endpoint = endpoint;
        self.pathComponents = pathComponents;
        self.queryParameters = queryParameters;
    }
    
    /// CONVENIENCE INITIALIZATION FOR URL
    convenience init?(url: URL){
        let string = url.absoluteString;
        
        if !string.contains(Constants.baseUrl){
            return nil;
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "");
        
        if(trimmed.contains("/")){
            let components = trimmed.components(separatedBy: "/");
            if !components.isEmpty{
                let endpointString = components[0];
                if let rmEndpoint = RMEndpoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint);
                    return;
                }
            }
        } else if (trimmed.contains("?")){
            let components = trimmed.components(separatedBy: "?");
            if !components.isEmpty{
                let endpointString = components[0];
                if let emEndpoint = RMEndpoint(rawValue: endpointString){
                    self.init(endpoint: emEndpoint)
                    return
                }
            }
        }
        
        return nil;
    }
}


extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
