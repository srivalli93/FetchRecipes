//
//  Recipes.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/10/25.
//

import SwiftUI

struct Recipe : Codable, Equatable {
    let name: String
    let cuisine: String
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let uuid: String
    let youtube_url: String?
}

struct Recipes : Codable {
    let recipes: [Recipe]
}

