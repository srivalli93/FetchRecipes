//
//  AsyncImageView.swift
//  RecipeApp
//
//  Created by Srivalli Kanchibotla on 2/11/25.
//

import SwiftUI

struct AsyncImageView: View {
    
    @StateObject private var imageCache = ImageCache()
    @State private var image: UIImage? = nil
    let url : String
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            Task {
                if let url = URL(string: url) as URL? {
                    self.image = await imageCache.loadImage(from: url)
                }
                
            }
            
        }
    }
    
    
    
}
