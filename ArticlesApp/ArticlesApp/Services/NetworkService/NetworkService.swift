//
//  NetworkService.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

// Network service protocol
protocol NetworkServiceProtocol {
    func request<T: Decodable>(endPoint: EndPoint) async throws -> T
}

//// API Service implementation
class NetworkService: NetworkServiceProtocol {
    
    private var session: URLSession
    
    init() {
        self.session = URLSession.shared
    }
    
    func request<T: Decodable>(
        endPoint: EndPoint
    ) async throws -> T {
        guard let url = endPoint.url else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        let (data, response) = try await self.session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
