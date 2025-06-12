//
//  RecipeDetailView.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/7/25.
//

import SwiftUI

/// The RecipeDetailView is shown when a recipe is selected and is responsible for showing further information about a recipe.
struct RecipeDetailView: View {
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    private let recipe: Recipe
    
    var body: some View {
        VStack(spacing: 12.0) {
            if let imageURLString = recipe.photoUrlLarge {
                
                CachableWebImage(imageUrlString: imageURLString, placeholder: "photo")
                    .frame(width: 350, height: 350)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 20))
            }
            Text(recipe.name)
                .font(.title)
            Text("\(recipe.cuisine) cuisine")
            if let sourceURLString = recipe.sourceUrl, let sourceUrl = URL(string: sourceURLString) {
                Link(destination: sourceUrl) {
                    Text("Learn More")
                }
            }
            
            if let youtubeUrlString = recipe.youtubeUrl, let youtubeUrl = URL(string: youtubeUrlString) {
                Link(destination: youtubeUrl) {
                    Text("Watch the Video")
                }
            }
        }
    }
}

#Preview {
    let bakewellTart = Recipe(uuid: "0123456789", name: "Bakewell Tart", cuisine: "British", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/large.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg", sourceUrl: "https://some.url/index.html", youtubeUrl: "https://www.youtube.com/watch?v=some.id")
    RecipeDetailView(recipe: bakewellTart)
}
