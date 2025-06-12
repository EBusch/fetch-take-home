//
//  RecipeProvider.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/7/25.
//

import Foundation
import SwiftData

/// The Recipe Provider is responsible for providing recipes given the URL.
struct RecipeProvider {
    /// The URL String that provides the JSON.
    let recipesUrlString = "" // TODO: Replace this with the proper URL.
    
    /// Fetches the recipes json, decodes them and stores them using SwiftData.
    /// - Parameter modelContext: The SwiftData model context to use.
    @MainActor
    public func fetch(modelContext: ModelContext) async throws {
        let jsonData = try await WebDataProvider.fetchData(urlString: recipesUrlString)
        let rawServerResponse = try JSONDecoder().decode(RawServerResponse.self, from: jsonData)
        let recipes = rawServerResponse.recipes
        
        DispatchQueue.main.async() {
            for recipe in recipes {
                modelContext.insert(recipe)
            }
        }
    }
}
