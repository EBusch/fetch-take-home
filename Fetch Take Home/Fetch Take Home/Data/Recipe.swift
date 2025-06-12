//
//  Recipe.swift
//  Fetch Take Home
//
//  Created by Eric Busch on 6/5/25.
//

import Foundation
import SwiftData

/// The Recipe model.
@Model
final class Recipe: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case cuisine
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
    @Attribute(.unique)
    var uuid: String
    var name: String
    var cuisine: String
    var photoUrlLarge: String?
    var photoUrlSmall: String?
    var sourceUrl: String?
    var youtubeUrl: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.name = try container.decode(String.self, forKey: .name)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.photoUrlLarge = try container.decodeIfPresent(String.self, forKey: .photoUrlLarge)
        self.photoUrlSmall = try container.decodeIfPresent(String.self, forKey: .photoUrlSmall)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        self.youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(cuisine, forKey: .cuisine)
        try container.encodeIfPresent(photoUrlLarge, forKey: .photoUrlLarge)
        try container.encodeIfPresent(photoUrlSmall, forKey: .photoUrlSmall)
        try container.encodeIfPresent(sourceUrl, forKey: .sourceUrl)
        try container.encodeIfPresent(youtubeUrl, forKey: .youtubeUrl)
    }
    
    init(uuid: String, name: String, cuisine: String, photoUrlLarge: String? = nil, photoUrlSmall: String? = nil, sourceUrl: String? = nil, youtubeUrl: String? = nil) {
        self.uuid = uuid
        self.name = name
        self.cuisine = cuisine
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

