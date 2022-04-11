//
//  MockURLSessionDataTask.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/11.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
