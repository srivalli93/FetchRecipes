//
//  ContentView.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/9/25.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject private var fetchService = RecipeService()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20.0) {
                            ForEach(fetchService.cuisines, id: \.self) { cuisine in
                                CuisineButton(cuisine: cuisine, isSelected: cuisine == fetchService.selectedCuisine) {
                                    fetchService.updatedSelectedCuisine(cuisine)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    List(fetchService.selectedRecipes, id: \.uuid) { recipe in
                        RecipeRow(recipe: recipe)
                    }
                    .listStyle(PlainListStyle())
                    .animation(.easeIn, value: fetchService.recipes)
                    .navigationTitle("Recipes")
                    .searchable(text: $fetchService.searchText)
                    .task {
                        await fetchService.fetchRecipes()
                    }
                }
            }
        }
    }
}

struct CuisineButton: View {
    
    var cuisine: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(cuisine)
                .padding()
                .fontWeight(isSelected ? .bold : .regular)
                .background(isSelected ? Color.orange.opacity(0.2) : .clear)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(isSelected ? Color.orange : Color.clear, lineWidth: 1.5))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct RecipeRow: View {
    
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImageView(url: recipe.photo_url_small ?? "")
                .frame(width: 100, height: 100)
                .clipShape(.rect(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.clear, lineWidth: 2))
            
            
            VStack (alignment: .leading, spacing: 3) {
                Text(recipe.name)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .transition(.slide)
    }
}

#Preview {
    RecipeListView()
}
