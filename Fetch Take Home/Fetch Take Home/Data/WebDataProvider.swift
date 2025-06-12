//
//  WebDataProvider.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/11/25.
//

import Foundation

/// The WebDataProvider is responsible for fetching data from the web, using caching.
struct WebDataProvider {
    /// Fetches the
    /// - Parameter urlString: A string representation of the URL to call.
    /// - Returns: The Data from the request.
    public static func fetchData(urlString: String) async throws -> Data {
        guard let fetchURL = URL(string: urlString) else {
            // NOTE: This would/should be more elegant, simplified for the sake of the example.
            throw NSError(domain: "Could not create URL to fetch data", code: 404)
        }
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        
        let (responseData, _) = try await URLSession.shared.data(for: request)
        
        return responseData
    }
}
