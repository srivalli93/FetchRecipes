//
//  RecipeListViewTests.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/11/25.
//

import XCTest
@testable import RecipeApp

class RecipeListViewTests: XCTestCase {
    
    func testEmptyState() {
        let recipeService = RecipeService()
        let recipeListView = RecipeListView().environmentObject(recipeService)
        
        let expectation = XCTestExpectation(description: "Empty State")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if recipeService.selectedRecipes.isEmpty {
//                let emptyStateView = recipeListView.inspect().find(EmptyStateView.self)
//                XCTAssertNotNil(emptyStateView, "Empty state view not displayed")
                expectation.fulfill()
                
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
}
