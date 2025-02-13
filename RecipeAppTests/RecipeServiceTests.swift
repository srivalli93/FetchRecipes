//
//  RecipeServiceTests.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/12/25.
//

import XCTest
@testable import RecipeApp

class RecipeServiceTests: XCTestCase {
    
    var recipeService: RecipeService!
    
    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
    }
    
    func testFetchRecipesEmptyJSON() async {
        let mockURL = URLManager.shared.emptyRecipeURL
        await recipeService.fetchRecipes(mockURL)
        
        XCTAssertEqual(recipeService.recipes.count, 0)
        XCTAssertEqual(recipeService.cuisines, ["All"])
    }
    
    func testFetchRecipesMalformedJSON() async {
        let mockURL = URLManager.shared.malformedRecipeURL
        await recipeService.fetchRecipes(mockURL)
        
        XCTAssertEqual(recipeService.recipes.count, 0)
        XCTAssertEqual(recipeService.cuisines.count, 1)
    }
}
