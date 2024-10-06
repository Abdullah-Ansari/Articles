//
//  MockNetworkService.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var articlesResponse: ArticlesResponse?

    func request<T: Decodable>(endPoint: EndPoint) async throws -> T {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
        }
        
        guard let response = articlesResponse as? T else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No articles returned"])
        }
        
        return response
    }
}
