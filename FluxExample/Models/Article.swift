//
//  Article.swift
//  FluxExample
//
//  Created by artembolotov on 08.02.2023.
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Article: Codable, Hashable, Identifiable {

    public var id: Int
    public var featured: Bool? = false
    public var title: String?
    public var url: String?
    public var imageUrl: String?
    public var newsSite: String?
    public var summary: String?
    public var publishedAt: String?
    
    public init(id: Int, featured: Bool? = false, title: String? = nil, url: String? = nil, imageUrl: String? = nil, newsSite: String? = nil, summary: String? = nil, publishedAt: String? = nil) {
        self.id = id
        self.featured = featured
        self.title = title
        self.url = url
        self.imageUrl = imageUrl
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case featured
        case title
        case url
        case imageUrl
        case newsSite
        case summary
        case publishedAt
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(featured, forKey: .featured)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(newsSite, forKey: .newsSite)
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeIfPresent(publishedAt, forKey: .publishedAt)
    }
}

