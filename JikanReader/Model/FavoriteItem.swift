//
//  FavoriteItem.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/9.
//

import Foundation

struct FavoriteItem: Codable, Identifiable, Equatable {
    let id: Int?
    let url: String?
    let images: [String: CoverImage]?
    let title, titleEnglish, titleJapanese: String?
    let type: String?
    let metadata: Metadata
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url, images, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case type = "type"
        case metadata
    }
    
    static func == (lhs: FavoriteItem, rhs: FavoriteItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension FavoriteItem {
    enum Metadata: Codable {
        case anime(aired: Aired)
        case manga(published: PublishedDate)
    }
}
