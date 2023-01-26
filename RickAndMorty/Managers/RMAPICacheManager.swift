//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Thuta Sann on 25/01/2023.
//

import Foundation

/// Manages in memory session scoped API Cache
final class RMAPICacheManager{
        
    // API URL: Data
    
    // For Different EndPoints
    private var cacheDictionary: [
        RMEndpoint: NSCache<NSString, NSData>
    ] = [:];
    
    
    // MARK: Initialization
    init(){
        setupCache();
    }
    
    // MARK: - Return Cached Response
    public func cachedResponse(for endPoint: RMEndpoint, url: URL?) -> Data?{
        guard let targetCache = cacheDictionary[endPoint], let url = url else{
            return nil;
        }
        let key = url.absoluteString as NSString;
        return targetCache.object(forKey: key) as? Data;
    }
    
    // MARK: - Set Cache Function
    public func setCache(for endPoint : RMEndpoint, url: URL?, data: Data){
        guard let targetCache = cacheDictionary[endPoint], let url = url else{
            return;
        }
        let key = url.absoluteString as NSString;
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    
    // MARK: - SetUp Cache Function (Private)
    private func setupCache(){
        RMEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>();
        })
    }
}
