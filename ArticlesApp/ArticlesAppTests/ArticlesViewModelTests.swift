//
//  ArticlesViewModelTests.swift
//  ArticlesAppTests
//
//  Created by Abdullah Ansari on 05/10/24.
//

import XCTest
@testable import ArticlesApp

final class ArticlesViewModelTests: XCTestCase {
    var sut: ArticlesViewModel!
    var mockRepository: MockArticleRepository!

    @MainActor override func setUp() {
        super.setUp()
        mockRepository = MockArticleRepository()
        sut = ArticlesViewModel(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchArticlesSuccess() async {
        // Arrange
        let expectedArticles = Article.getArticles()
        mockRepository.articlesToReturn = expectedArticles
        
        // Act
        await sut.fetchArticles()
        
        // Assert
       await MainActor.run {
           XCTAssertEqual(sut.articles.count, expectedArticles.count)
           XCTAssertEqual(sut.articles[0].title, expectedArticles[0].title)
           XCTAssertFalse(sut.isLoading)
           XCTAssertNil(sut.errorMessage)
       }
    }
    
    func testFetchArticlesFailure() async {
        // Arrange
        mockRepository.shouldReturnError = true
          
        // Act
        await sut.fetchArticles()
          
        // Assert
        await MainActor.run {
            XCTAssertTrue(sut.articles.isEmpty)
            XCTAssertFalse(sut.isLoading)
            XCTAssertEqual(sut.errorMessage, "Failed to load articles: Mock error")
        }
    }
    
    func testFetchArticlesLoadingState() async {
        // Act
        let fetchTask = Task { await sut.fetchArticles() }
        
        // Yield control to allow any pending updates
        await Task.yield()
        
        // Assert loading state is true before completion
        await MainActor.run {
            XCTAssertTrue(sut.isLoading, "Loading state should be true while fetching articles.")
        }
        
        // Wait for the task to complete
        await fetchTask.value
        
        // Assert loading state is false after completion
        await MainActor.run {
            XCTAssertFalse(sut.isLoading, "Loading state should be false after fetching articles.")
        }
    }
}

extension Article {
   
    static func getArticles() -> [Article] {
        [
            Article(uri: "test1", url: "http://example1.com", id: 1, assetID: 101, source: .newYorkTimes, publishedDate: "2023-10-04", updated: "2023-10-05", section: "Tech", subsection: "AI", nytdsection: "NYT", adxKeywords: "AI,Tech", title: "Article 1", abstract: "Test Abstract1", desFacet: ["Tech"], orgFacet: ["NYT"], perFacet: ["Author"], geoFacet: ["USA"], media: nil, etaID: 1001),
            
            Article(uri: "test2", url: "http://example2.com", id: 1, assetID: 102, source: .newYorkTimes, publishedDate: "2023-10-04", updated: "2023-10-05", section: "Tech", subsection: "AI", nytdsection: "NYT", adxKeywords: "AI,Tech", title: "Article 1", abstract: "Test Abstract2", desFacet: ["Tech"], orgFacet: ["NYT"], perFacet: ["Author"], geoFacet: ["USA"], media: nil, etaID: 1002),
        ]
    }
}
