//
//  Fetch_Take_HomeApp.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/5/25.
//

import SwiftUI
import SwiftData

@main
struct FetchTakeHomeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
