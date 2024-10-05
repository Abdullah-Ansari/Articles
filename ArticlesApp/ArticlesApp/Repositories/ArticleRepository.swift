//
//  ArticleRepository.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

// Article repository protocol
protocol ArticleRepositoryProtocol {
    func fetchArticles() async throws -> [Article]
}

// Article repository implementation
class ArticleRepository: ArticleRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let apiKey: String

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        apiKey = APIConstants.apiKey
    }

    func fetchArticles() async throws -> [Article] {
        let parameters = ["api-key": apiKey]
        let endPoint = EndPointBuilder()
            .setPath(.getArticles)
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .setParameters(parameters)
            .build()
        let response: ArticlesResponse = try await networkService.request(endPoint: endPoint)
        return response.results ?? []
    }
}
