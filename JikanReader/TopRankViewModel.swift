//
//  TopRankViewModel.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import Foundation

class TopRankViewModel: ObservableObject {
    @Published var typeSelection = 0
    @Published var animeTypeSelection = 0
    @Published var mangaTypeSelection = 0
    @Published var topAnimeList: [Anime] = [Anime]()
    @Published var topMangaList: [Manga] = [Manga]()
    @Published var isLoading = false
    
    let listType = ["Anime", "Manga"]
    let animeType = ["All", "TV", "Movie", "OVA", "Special", "ONA", "Music"]
    let mangaType = ["All", "Manga", "Novel", "LightNovel", "Oneshot", "Doujin", "Manhwa", "Manhua"]
    
    private var loadedAnimePage = 1
    private var loadedMangaPage = 1
    private var apiService: JikanAPIServiceProtocol
    
    init(apiService: JikanAPIServiceProtocol = JikanAPIService()) {
        self.apiService = apiService
    }
        
    func initTopRankList() {
        if topAnimeList.isEmpty {
            fetchTopAnime(type:nil, page: 1)
        }
        
        if topMangaList.isEmpty {
            fetchTopManga(type:nil, page: 1)
        }
    }
    
    func selectAnimeType(_ type: String) {
        resetLoadedAnimeList()
        
        if type == "All" {
            fetchTopAnime(type:nil, page: 1)
        }
        else {
            fetchTopAnime(type:type, page: 1)
        }
    }
    
    func selectMangaType(_ type: String) {
        resetLoadedMangaList()
        
        if type == "All" {
            fetchTopManga(type:nil, page: 1)
        }
        else {
            fetchTopManga(type:type, page: 1)
        }
    }
    
    func fetchNextAnimePage() {
        fetchTopAnime(type:animeType[animeTypeSelection], page: loadedAnimePage + 1)
        loadedAnimePage += 1
    }

    func fetchNextMangaPage() {
        fetchTopManga(type:mangaType[mangaTypeSelection], page: loadedMangaPage + 1)
        loadedMangaPage += 1
    }

    func refreshCurrentList() {
        if typeSelection == 0 {
            animeTypeSelection != 0 ? fetchTopAnime(type:animeType[animeTypeSelection], page: loadedAnimePage): fetchTopAnime(type:nil, page: loadedAnimePage)
        }
        else {
            mangaTypeSelection != 0 ? fetchTopManga(type:mangaType[mangaTypeSelection], page: loadedMangaPage): fetchTopManga(type:nil, page: loadedMangaPage)
        }
    }
    
    private func fetchTopAnime(type: String?, page: Int) {
        isLoading = true
        
        apiService.fetchTopAnime(type: type,
                                 page: page,
                                 completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let topList = response.data {
                        var existingList = self.topAnimeList
                        var newList = [Anime]()
                        
                        for anime in topList {
                            if !existingList.contains(anime) {
                                newList.append(anime)
                            }
                        }
                        existingList.append(contentsOf: newList)
                        
                        self.topAnimeList = existingList.sorted(by: { $0.rank! < $1.rank! })
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        })
    }
    
    private func fetchTopManga(type: String?, page: Int) {
        isLoading = true
        
        apiService.fetchTopManga(type: type,
                                 page: page,
                                 completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let topList = response.data {
                        var existingList = self.topMangaList
                        var newList = [Manga]()
                        
                        for manga in topList {
                            if !existingList.contains(manga) {
                                newList.append(manga)
                            }
                        }
                        existingList.append(contentsOf: newList)
                        
                        self.topMangaList = existingList.sorted(by: { $0.rank! < $1.rank! })
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        })
    }
    
    private func resetLoadedAnimeList() {
        loadedMangaPage = 1
        topAnimeList.removeAll()
    }
    
    private func resetLoadedMangaList() {
        loadedMangaPage = 1
        topMangaList.removeAll()
    }

    private func resetLoadedList() {
        resetLoadedAnimeList()
        resetLoadedMangaList()
    }
}
