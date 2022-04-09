//
//  JikanAPIGetTopManga.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import Foundation

// MARK: - JikanAPIGetTopManga
struct JikanAPIGetTopManga: Codable {
    let data: [Manga]?
    let pagination: Pagination?
}

// MARK: - Manga
struct Manga: Codable, Identifiable, Equatable {
    let id: Int?
    let url: String?
    let images: [String: CoverImage]?
    let title, titleEnglish, titleJapanese: String?
    let titleSynonyms: [String]?
    let type: String?
    let chapters, volumes: Int?
    let status: String?
    let publishing: Bool?
    let published: PublishedDate?
    let score, scoredBy, rank, popularity: Float?
    let members, favorites: Int?
    let synopsis, background: String?
    let authors, serializations, genres, explicitGenres: [Author]?
    let themes, demographics: [Author]?

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case url, images, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, chapters, volumes, status, publishing, published, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, authors, serializations, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
    
    static func == (lhs: Manga, rhs: Manga) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Author
struct Author: Codable {
    let malID: Int?
    let type, name, url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Published
struct PublishedDate: Codable {
    let from, to: String?
    let prop: Prop?
}
