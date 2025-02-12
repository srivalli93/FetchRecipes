//
//  MockRecipes.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/11/25.
//

import Foundation

struct MockRecipes: Decodable {
    static func getMockRecipes() -> [Recipe] {
        return [
            Recipe(name: "test", cuisine: "test", photo_url_large: "", photo_url_small: nil, source_url: nil, uuid: "test", youtube_url: "test"),
            Recipe(name: "test", cuisine: "test", photo_url_large: "", photo_url_small: nil, source_url: nil, uuid: "test", youtube_url: "test"),
            Recipe(name: "test", cuisine: "test", photo_url_large: "", photo_url_small: nil, source_url: nil, uuid: "test", youtube_url: "test"),
            Recipe(name: "test", cuisine: "test", photo_url_large: "", photo_url_small: nil, source_url: nil, uuid: "test", youtube_url: "test"),
            Recipe(name: "test", cuisine: "test", photo_url_large: "", photo_url_small: nil, source_url: nil, uuid: "test", youtube_url: "test")
        ]
    }
}
