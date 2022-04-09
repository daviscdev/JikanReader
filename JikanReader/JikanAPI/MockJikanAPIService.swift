//
//  MockJikanAPIService.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/9.
//

import Foundation

class MockJikanAPIService: JikanAPIServiceProtocol {
    var fetchTopAnimeResult: JikanAPIGetTopAnime?
    var fetchTopMangaResult: JikanAPIGetTopManga?
    var error: JikanAPIServiceError?
    var type: String?
    var page: Int = 1
    
    func fetchTopAnime(type: String?, page: Int, completionHandler: @escaping (Result<JikanAPIGetTopAnime, JikanAPIServiceError>) -> Void) {
        self.type = type
        self.page = page
        
        guard let result = fetchTopAnimeResult else {
            if let error = error {
                completionHandler(.failure(error))
            }
            else {
                completionHandler(.failure(.urlError))
            }
            return
        }
        
        completionHandler(.success(result))
    }
    
    func fetchTopManga(type: String?, page: Int, completionHandler: @escaping (Result<JikanAPIGetTopManga, JikanAPIServiceError>) -> Void) {
        self.type = type
        self.page = page
        
        guard let result = fetchTopMangaResult else {
            if let error = error {
                completionHandler(.failure(error))
            }
            else {
                completionHandler(.failure(.urlError))
            }
            return
        }
        
        completionHandler(.success(result))
    }
}
