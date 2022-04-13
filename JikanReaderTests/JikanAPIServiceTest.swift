//
//  JikanAPIServiceTest.swift
//  JikanReaderTests
//
//  Created by rensakura on 2022/4/11.
//

import XCTest
@testable import JikanReader

class JikanAPIServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchTopAnimeJsonDecodeError() {
        let mockURLSession = MockURLSession()
        mockURLSession.data = "test".data(using: .utf8)
        mockURLSession.error = nil
        let service = JikanAPIService(urlSession: mockURLSession)
        
        var result: Result<JikanAPIGetTopAnime, JikanAPIServiceError>?
        service.fetchTopAnime(type: nil, page: 1, completionHandler: { result = $0 })
        
        let error = NSError(domain: "test", code: 404)
        XCTAssertEqual(result, .failure(.jsonDecodeError(error: error)))
    }
    
    func testFetchTopAnimeNetworkError() {
        let mockURLSession = MockURLSession()
        mockURLSession.data = nil
        mockURLSession.error = NSError(domain: "test", code: 404)
        let service = JikanAPIService(urlSession: mockURLSession)
        
        var result: Result<JikanAPIGetTopAnime, JikanAPIServiceError>?
        service.fetchTopAnime(type: nil, page: 1, completionHandler: { result = $0 })
        
        XCTAssertEqual(result, .failure(.networkError(error: NSError(domain: "test", code: 404))))
    }
    
    func testFetchTopAnimeNoResponseError() {
        let mockURLSession = MockURLSession()
        mockURLSession.data = nil
        mockURLSession.error = nil
        let service = JikanAPIService(urlSession: mockURLSession)
        
        var result: Result<JikanAPIGetTopAnime, JikanAPIServiceError>?
        service.fetchTopAnime(type: nil, page: 1, completionHandler: { result = $0 })
        
        XCTAssertEqual(result, .failure(.noResponse))
    }
    
    func testFetchTopAnime() {
        let mockURLSession = MockURLSession()
        
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "fetchTopAnimeResponse", ofType: "txt") else {
            XCTFail()
            return
        }
        mockURLSession.data = FileManager.default.contents(atPath: path)
        mockURLSession.error = nil
        let service = JikanAPIService(urlSession: mockURLSession)
        
        var result: Result<JikanAPIGetTopAnime, JikanAPIServiceError>?
        service.fetchTopAnime(type: nil, page: 1, completionHandler: { result = $0 })
        
        let data = [Anime(id: 0, url: "string", images: ["webp": CoverImage(imageURL: "string", smallImageURL: "string", largeImageURL: "string"), "jpg": CoverImage(imageURL: "string", smallImageURL: "string", largeImageURL: "string")], trailer: Trailer(youtubeID: "string", url: "string", embedURL: "string"), title: "string", titleEnglish: "string", titleJapanese: "string", titleSynonyms: ["string"], type: "TV", source: "string", episodes: 0, status: "Finished Airing", airing: true, aired: Aired(from: "string", to: "string", prop: Prop(from: From(day: 0, month: 0, year: 0), to: From(day: 0, month: 0, year: 0), string: "string")), duration: "string", rating: "G - All Ages", score: 0.0, scoredBy: 0.0, rank: 0.0, popularity: 0.0, members: 0, favorites: 0, synopsis: "string", background: "string", season: "Summer", year: 0, broadcast: Broadcast(day: "string", time: "string", timezone: "string", string: "string"), producers: [Demographic(malID: 0, type: "string", name: "string", url: "string")], licensors: [Demographic(malID: 0, type: "string", name: "string", url: "string")], studios: [Demographic(malID: 0, type: "string", name: "string", url: "string")], genres: [Demographic(malID: 0, type: "string", name: "string", url: "string")], explicitGenres: [Demographic(malID: 0, type: "string", name: "string", url: "string")], themes: [Demographic(malID: 0, type: "string", name: "string", url: "string")], demographics: [Demographic(malID: 0, type: "string", name: "string", url: "string")])]
        let pagination = Pagination(lastVisiblePage: 0, hasNextPage: true)
        
        XCTAssertEqual(result, .success(JikanAPIGetTopAnime(data: data, pagination: pagination)))
    }
}
