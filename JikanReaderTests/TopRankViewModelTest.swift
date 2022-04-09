//
//  TopRankViewModelTest.swift
//  JikanReaderTests
//
//  Created by rensakura on 2022/4/9.
//

import XCTest
@testable import JikanReader

class TopRankViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitTopRankList() {
        let mockJikanAPIService = MockJikanAPIService()
        let animeResult = JikanAPIGetTopAnime(data: [Anime(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], trailer: nil, title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: 5.0, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil)], pagination: nil)
       
        let mangaResult = JikanAPIGetTopManga(data: [Manga(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, chapters: nil, volumes: nil, status: nil, publishing: nil, published: nil, score: nil, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, authors: nil, serializations: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil)], pagination: nil)
        
        mockJikanAPIService.fetchTopAnimeResult = animeResult
        mockJikanAPIService.fetchTopMangaResult = mangaResult
        
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        
        viewModel.initTopRankList()
        
        if XCTWaiter.wait(for: [expectation(description: "Test after 0.5 seconds")], timeout: 0.5) == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.topAnimeList.count, 1)
            XCTAssertEqual(viewModel.topMangaList.count, 1)
            XCTAssertEqual(viewModel.topAnimeList.first?.titleEnglish, "test")
            XCTAssertEqual(viewModel.topMangaList.first?.titleEnglish, "test")
        } else {
            XCTFail("Delay interrupted")
        }
    }

    func testSelectAnimeType() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        
        viewModel.selectAnimeType("test")
        
        XCTAssertEqual(mockJikanAPIService.type, "test")
        XCTAssertEqual(mockJikanAPIService.page, 1)
    }
    
    func testSelectMangaType() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        
        viewModel.selectMangaType("test")
        
        XCTAssertEqual(mockJikanAPIService.type, "test")
        XCTAssertEqual(mockJikanAPIService.page, 1)
    }
    
    func testFetchNextAnimePage() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.animeTypeSelection = 1
        
        viewModel.fetchNextAnimePage()
        
        XCTAssertEqual(mockJikanAPIService.type, "TV")
        XCTAssertEqual(mockJikanAPIService.page, 2)
        
        viewModel.fetchNextAnimePage()
        
        XCTAssertEqual(mockJikanAPIService.type, "TV")
        XCTAssertEqual(mockJikanAPIService.page, 3)
    }
    
    func testFetchNextMangaPage() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.mangaTypeSelection = 1
        
        viewModel.fetchNextMangaPage()
        
        XCTAssertEqual(mockJikanAPIService.type, "Manga")
        XCTAssertEqual(mockJikanAPIService.page, 2)
        
        viewModel.fetchNextMangaPage()
        
        XCTAssertEqual(mockJikanAPIService.type, "Manga")
        XCTAssertEqual(mockJikanAPIService.page, 3)
    }
    
    func testfetchNextMangaPage() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.mangaTypeSelection = 1
        
        viewModel.fetchNextMangaPage()
        
        XCTAssertEqual(mockJikanAPIService.type, "Manga")
        XCTAssertEqual(mockJikanAPIService.page, 2)
        
        viewModel.fetchNextMangaPage()
        
        XCTAssertEqual(mockJikanAPIService.type, "Manga")
        XCTAssertEqual(mockJikanAPIService.page, 3)
    }
    
    func testRefreshCurrentListManga() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.typeSelection = 1
        viewModel.mangaTypeSelection = 1
        
        viewModel.refreshCurrentList()
        
        XCTAssertEqual(mockJikanAPIService.type, "Manga")
        XCTAssertEqual(mockJikanAPIService.page, 1)
    }
    
    func testRefreshCurrentListMangaAll() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.typeSelection = 1
        viewModel.mangaTypeSelection = 0
        
        viewModel.refreshCurrentList()
        
        XCTAssertNil(mockJikanAPIService.type)
        XCTAssertEqual(mockJikanAPIService.page, 1)
    }
    
    func testRefreshCurrentListAnime() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.typeSelection = 0
        viewModel.animeTypeSelection = 1
        
        viewModel.refreshCurrentList()
        
        XCTAssertEqual(mockJikanAPIService.type, "TV")
        XCTAssertEqual(mockJikanAPIService.page, 1)
    }
    
    func testRefreshCurrentListAnimeAll() {
        let mockJikanAPIService = MockJikanAPIService()
        let viewModel = TopRankViewModel(apiService: mockJikanAPIService)
        viewModel.typeSelection = 0
        viewModel.animeTypeSelection = 0
        
        viewModel.refreshCurrentList()
        
        XCTAssertNil(mockJikanAPIService.type)
        XCTAssertEqual(mockJikanAPIService.page, 1)
    }
}
