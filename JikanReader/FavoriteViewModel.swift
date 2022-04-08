//
//  FavoriteViewModel.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import Foundation

struct FavoriteItem: Identifiable, Equatable {
    let id: Int?
    let url: String?
    let images: [String: CoverImage]?
    let title, titleEnglish, titleJapanese: String?
    var metadata: Metadata
    
    static func == (lhs: FavoriteItem, rhs: FavoriteItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension FavoriteItem {
    enum Metadata {
        case anime(aired: Aired)
        case manga(published: PublishedDate)
    }
}

class FavoriteViewModel: ObservableObject {    
    @Published var favoriteList: [FavoriteItem] = []
    
    init() {
        //
    }
}
