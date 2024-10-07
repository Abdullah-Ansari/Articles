//
//  MockArticleRepository.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

import Foundation

class MockArticleRepository: ArticleRepositoryProtocol {
    var shouldReturnError = false
    var articlesToReturn: [Article] = []

    func fetchArticles() async throws -> [Article] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        return articlesToReturn
    }
}
