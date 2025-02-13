//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/10/25.
//

import Foundation

class RecipeService : ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipes: [Recipe] = []
    @Published var selectedCuisine: String = "All"
    @Published var searchText: String = ""
    @Published var cuisines: [String] = ["All"]
    
    //this updates the UI data. Hence we are running it on MainActor to ensure the updates happen on main thread
    func fetchRecipes(_ url: String) async {
        
        guard let url = URL(string: url) else {
            return
        }
        
        //fetch data from url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Recipes.self, from: data)
            DispatchQueue.main.async {
                self.recipes = decodedData.recipes
                self.selectedRecipes = decodedData.recipes
                self.cuisines = Array(Set(self.recipes.map { $0.cuisine })).sorted()
                self.cuisines.insert( "All", at: 0)
            }
            
            
        } catch {
            print("could not fetch data")
            print(error.localizedDescription)
        }
        
    }
    
    func filterRecipes(by cuisine: String) {
        
        if cuisine == "All" {
            selectedRecipes = recipes
        } else {
            selectedRecipes = recipes.filter { $0.cuisine == cuisine }
        }
    }
    
    func updatedSelectedCuisine(_ cuisine: String) {
        selectedCuisine = cuisine
        filterRecipes(by: cuisine)
    }
    
    func updateSearchText(_ text: String) {
        searchText = text
        filterRecipesBySearchText()
    }
    
    func filterRecipesBySearchText() {
        if searchText.isEmpty {
            filterRecipes(by: selectedCuisine)
        } else {
            selectedRecipes = recipes.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
