//
//  ImageCache.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/11/25.
//

import SwiftUI

class ImageCache: ObservableObject {
    
    private var cache = URLCache.shared
    
    func loadImage(from url: URL) async -> UIImage? {
        
        //check if image is already in the cache
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)), let image = UIImage(data: cachedResponse.data) {
            return image
        }
        
        //if the image is not cached
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                //caching the image
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
                let cachedData = CachedURLResponse(response: response!, data: data)
                cache.storeCachedResponse(cachedData, for: URLRequest(url: url))
                return image
            }
        } catch {
            print("error loading image")
        }
        
        return nil
    }
}
