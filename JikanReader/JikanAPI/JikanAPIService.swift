//
//  JikanAPIService.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import Foundation

enum JikanAPIServiceError: Error, Equatable {
    case noResponse
    case urlError
    case jsonDecodeError(error: Error)
    case networkError(error: Error)
    
    static func == (lhs: JikanAPIServiceError, rhs: JikanAPIServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.noResponse, .noResponse):
            return true
        case (.urlError, .urlError):
            return true
        case (.jsonDecodeError(error: _), .jsonDecodeError(error: _)):
            return true
        case (.networkError(error: _), .networkError(error: _)):
            return true
        default:
            return false
        }
    }
}

protocol JikanAPIServiceProtocol {
    func fetchTopAnime(type: String?, page: Int, completionHandler: @escaping (Result<JikanAPIGetTopAnime, JikanAPIServiceError>) -> Void)
    func fetchTopManga(type: String?, page: Int, completionHandler: @escaping (Result<JikanAPIGetTopManga, JikanAPIServiceError>) -> Void)
}

struct JikanAPIService: JikanAPIServiceProtocol {
    private let baseURL = "https://api.jikan.moe/v4"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
         self.urlSession = urlSession
     }
    
    private func makeURL(endpoint: String, param: String) -> URL? {
        return URL(string: baseURL + "\(endpoint)?\(param)")
    }
    
    private func httpGETRequest<T: Codable>(url: URL, completionHandler: @escaping (Result<T, JikanAPIServiceError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(.networkError(error: error)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noResponse))
                return
            }
            
            do {
                let topAnimeList = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(topAnimeList))
            } catch let error {
                completionHandler(.failure(.jsonDecodeError(error: error)))
            }
        }
        task.resume()
    }
}

extension JikanAPIService {
    func fetchTopAnime(type: String?, page: Int, completionHandler: @escaping (Result<JikanAPIGetTopAnime, JikanAPIServiceError>) -> Void) {
        var param = "page=\(page)"
        if let type = type {
            param += "&type=\(type)"
        }
        
        guard let url = makeURL(endpoint: "/top/anime", param: param) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        httpGETRequest(url: url, completionHandler: completionHandler)
    }
    
    func fetchTopManga(type: String?, page: Int, completionHandler: @escaping (Result<JikanAPIGetTopManga, JikanAPIServiceError>) -> Void) {
        var param = "page=\(page)"
        if let type = type {
            param += "&type=\(type)"
        }
        
        guard let url = makeURL(endpoint: "/top/manga", param: param) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        httpGETRequest(url: url, completionHandler: completionHandler)
    }
}
