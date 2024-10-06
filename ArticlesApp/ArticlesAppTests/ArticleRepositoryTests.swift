//
//  ArticleRepositoryTests.swift
//  ArticlesAppTests
//
//  Created by Abdullah Ansari on 05/10/24.
//

import XCTest
@testable import ArticlesApp

final class ArticleRepositoryTests: XCTestCase {
    var sut: ArticleRepository!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = ArticleRepository(networkService: mockNetworkService)
    }

    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchArticlesSuccess() async {
        // Arrange
        let expectedArticles = Article.getArticles()
        let articleResponse = ArticlesResponse(status: nil, copyright: nil, numResults: expectedArticles.count, results: expectedArticles)
        mockNetworkService.articlesResponse = articleResponse
        
        // Act
        do {
            let articles = try await sut.fetchArticles()
            
            // Assert
            XCTAssertEqual(articles.count, expectedArticles.count)
            XCTAssertEqual(articles[0].title, expectedArticles[0].title)
            XCTAssertEqual(articles[1].title, expectedArticles[1].title)
        } catch {
            XCTFail("Expected successful fetching of articles but got an error: \(error)")
        }
    }

    func testFetchArticlesFailure() async {
        // Arrange
        mockNetworkService.shouldReturnError = true
        
        // Act
        do {
            _ = try await sut.fetchArticles()
            XCTFail("Expected to throw an error but succeeded")
        } catch {
            // Assert that the error is thrown as expected
            XCTAssertEqual((error as NSError).localizedDescription, "Mock network error")
        }
    }
}
