//
//  RawServerResponse.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/6/25.
//

import Foundation
import SwiftData

/// A class to help with the raw server response. This may seem like it is not needed, but it keeps the implementation clean and easy given the way the json response comes in.
@Model
final class RawServerResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case recipes
    }
    var recipes: [Recipe]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recipes = try container.decode([Recipe].self, forKey: .recipes)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recipes, forKey: .recipes)
    }
}
