//
//  MockURLSession.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/11.
//

import Foundation

class MockURLSession: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
