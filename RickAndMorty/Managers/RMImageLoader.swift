//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Thuta sann on 1/5/23.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader();
    
    // MARK: NSChache
    private var imageDataCache = NSCache<NSString, NSData>();
    
    // MARK: Init
    private init(){}
    
    /// Get Image Content with URL
    /// - Parameters:
    ///   - url: Source URL
    ///   - completion: CallBack
    public func downloadImage(_ url : URL, completion: @escaping(Result<Data, Error>) -> Void){
        
        let key = url.absoluteString as NSString;
        
        if let data = imageDataCache.object(forKey: key){
            print("Reading From Cache \(key)")
            completion(.success(data as Data)) // NSData == Data | NSString == String
            return;
        }
        
        let request = URLRequest(url: url);
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)));
                return;
            }
            
            let value = data as NSData;
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume();
    }
}
