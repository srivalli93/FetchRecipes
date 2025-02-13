//
//  ContentView.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/9/25.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject private var fetchService = RecipeService()
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            VStack {
                // takes care of loading state
                if isLoading {
                    ProgressView("Loading your recipes ...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if fetchService.selectedRecipes.isEmpty {
                    EmptyStateView {
                        Task {
                            await fetchService.fetchRecipes(URLManager.shared.recipeURL)
                        }
                    }
                    
                } else {
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
                }
            }
            .task {
                await fetchService.fetchRecipes(URLManager.shared.recipeURL)
                isLoading = false
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
                .fontWeight(isSelected ? .semibold : .regular)
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
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .padding()
        }
        .padding(.vertical, 8)
        .transition(.slide)
        .onTapGesture {
            if let urlString = recipe.source_url, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}

struct EmptyStateView: View {
    var retryAction: (() -> Void)?
    
    var body: some View {
        VStack {
            Image(systemName: "folder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("No recipes found")
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.secondary.opacity(0.3))
                        .cornerRadius(10)
                }
                .padding()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    RecipeListView()
}
