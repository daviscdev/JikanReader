//
//  FavoriteViewModel.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var favoriteList: [FavoriteItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(favoriteList) {
                UserDefaults.standard.set(encoded, forKey: "favoriteList")
            }
        }
    }

    init() {
        if let favoriteList = UserDefaults.standard.object(forKey: "favoriteList") as? Data {
            if let decodedFavoriteList = try? JSONDecoder().decode([FavoriteItem].self, from: favoriteList) {
                self.favoriteList = decodedFavoriteList
            }
        }
    }
        
    func add(_ item: FavoriteItem) {
        if !favoriteList.contains(item) {
            favoriteList.append(item)
        }
    }
    
    func remove(_ item: FavoriteItem) {
        if let index = favoriteList.firstIndex(of: item) {
            favoriteList.remove(at: index)
        }
    }
}
