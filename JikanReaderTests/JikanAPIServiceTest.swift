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
}
