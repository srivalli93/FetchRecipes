//
//  InternalURLs.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/12/25.
//

import Foundation

class URLManager {
    
    static let shared = URLManager()
    
    private let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    
    private let recipeEndpoint = "recipes.json"
    private let emptyRecipeEndpoint = "recipes-empty.json"
    private let malformedRecipeEndpoint = "recipes-malformed.json"
    
    var recipeURL: String {
        return baseURL + recipeEndpoint
    }
    
    var emptyRecipeURL: String {
        return baseURL + emptyRecipeEndpoint
    }
    
    var malformedRecipeURL: String {
        return baseURL + malformedRecipeEndpoint
    }
    
    private init() {}
}
