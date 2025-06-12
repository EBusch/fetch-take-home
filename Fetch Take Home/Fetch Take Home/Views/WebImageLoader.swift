//
//  WebImageLoader.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/12/25.
//


import Foundation
import Combine
import SwiftUI

/// The WebImageLoader is responsible for loading an image from the web using caching, while using Combine to provide the best use with SwiftUI.
class WebImageLoader: ObservableObject {
    @Published var data: Data?
    @Published var loadingError: Bool?

    init(imageUrlString: String) {
        if let imageUrl = URL(string: imageUrlString) {
            let request = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    DispatchQueue.main.async() {
                        self.loadingError = true
                    }
                } else {
                    guard let data = data else { return }
                    DispatchQueue.main.async() {
                        self.data = data
                    }
                }
            }
            .resume()
        }
    }
}