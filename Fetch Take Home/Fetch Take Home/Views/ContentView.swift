//
//  ContentView.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/5/25.
//

import SwiftUI
import SwiftData

/// The main content view for the app.
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]
    @State private var selectedRecipe: Recipe?
    @State private var showingError = false
    
    var recipeProvider = RecipeProvider()

    var body: some View {
        NavigationSplitView {
            List(recipes, id: \.self, selection: $selectedRecipe) { recipe in
                NavigationLink(destination: {
                    if let selectedRecipe = selectedRecipe {
                        RecipeDetailView(recipe: selectedRecipe)
                    }
                }, label: {
                    HStack {
                        if let thumbnail = recipe.photoUrlSmall {
                            CachableWebImage(imageUrlString: thumbnail, placeholder: "photo")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .clipShape(.rect(cornerRadius: 8))
                        }
                        VStack(alignment: .leading, content: {
                            Text(recipe.name)
                            Text("\(recipe.cuisine) cuisine").font(.caption)
                        })
                    }
                })
            }
            .refreshable {
                await refreshData()
            }
            .task {
                if recipes.isEmpty {
                    await refreshData()
                }
            }
            .overlay {
                if recipes.isEmpty {
                    Text("There are not currently any recipes loaded.")
                }
                
            }
        }
        detail: {
            if let selectedRecipe = selectedRecipe {
                RecipeDetailView(recipe: selectedRecipe)
            } else {
                if recipes.isEmpty {
                    Text("Loading Recipes...")
                } else {
                    Text("Select A Recipe")
                }
            }
        }
        .alert("An error has occurred with the server, please check your internet connection and try again.", isPresented: $showingError) {
            Button("Retry", role: .none) {
                Task {
                    await refreshData()
                }
            }
            Button("Ok", role: .cancel) { }
        }
    }
    
    func refreshData() async {
        do {
            try await recipeProvider.fetch(modelContext: self.modelContext)
        } catch {
            showingError = true
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Recipe.self, configurations: config)
        
        let bakewellTart = Recipe(uuid: "0123456789", name: "Bakewell Tart", cuisine: "British", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/large.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg", sourceUrl: "https://some.url/index.html", youtubeUrl: "https://www.youtube.com/watch?v=some.id")
        container.mainContext.insert(bakewellTart)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
