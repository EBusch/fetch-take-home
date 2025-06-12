//
//  CachableWebImage.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/11/25.
//

import Foundation
import SwiftUI

/// The CachableWebImage that can display a progress view during loading, a fallback placeholder image for failure and shows the image once it has loaded.
struct CachableWebImage: View {
    @ObservedObject var webImageLoader: WebImageLoader
    var placeholderImage: String
    
    init(imageUrlString: String, placeholder: String) {
        webImageLoader = WebImageLoader(imageUrlString: imageUrlString)
        placeholderImage = placeholder
    }

    var body: some View {
        if webImageLoader.loadingError == true {
            Image(systemName: placeholderImage)
        }
        if let imageData = webImageLoader.data, let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .renderingMode(.original)
        } else {
            ProgressView()
        }
    }
}


