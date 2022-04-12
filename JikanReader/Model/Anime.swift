//
//  JikanAPIGetTopAnime.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import Foundation

// MARK: - JikanAPIGetTopAnime
struct JikanAPIGetTopAnime: Codable, Equatable {
    let data: [Anime]?
    let pagination: Pagination?
    
    static func == (lhs: JikanAPIGetTopAnime, rhs: JikanAPIGetTopAnime) -> Bool {
        lhs.data == rhs.data
    }
}

// MARK: - Manga
struct Anime: Codable, Identifiable, Equatable {
    let id: Int?
    let url: String?
    let images: [String: CoverImage]?
    let trailer: Trailer?
    let title, titleEnglish, titleJapanese: String?
    let titleSynonyms: [String]?
    let type, source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let aired: Aired?
    let duration, rating: String?
    let score, scoredBy, rank, popularity: Float?
    let members, favorites: Int?
    let synopsis, background, season: String?
    let year: Int?
    let broadcast: Broadcast?
    let producers, licensors, studios, genres: [Demographic]?
    let explicitGenres, themes, demographics: [Demographic]?

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case url, images, trailer, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, season, year, broadcast, producers, licensors, studios, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
    
    static func == (lhs: Anime, rhs: Anime) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Aired
struct Aired: Codable {
    let from, to: String?
    let prop: Prop?
}

// MARK: - Prop
struct Prop: Codable {
    let from, to: From?
    let string: String?
}

// MARK: - From
struct From: Codable {
    let day, month, year: Int?
}

// MARK: - Broadcast
struct Broadcast: Codable {
    let day, time, timezone, string: String?
}

// MARK: - Demographic
struct Demographic: Codable {
    let malID: Int?
    let type, name, url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Image
struct CoverImage: Codable {
    let imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    let youtubeID, url, embedURL: String?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let lastVisiblePage: Int?
    let hasNextPage: Bool?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
    }
}
