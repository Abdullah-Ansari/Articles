//
//  ArticlesViewModelTests.swift
//  ArticlesAppTests
//
//  Created by Abdullah Ansari on 05/10/24.
//

import XCTest
@testable import ArticlesApp

final class ArticlesViewModelTests: XCTestCase {
    var viewModel: ArticlesViewModel!
    var mockRepository: MockArticleRepository!

    @MainActor override func setUp() {
        super.setUp()
        mockRepository = MockArticleRepository()
        viewModel = ArticlesViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchArticlesSuccess() async {
        // Arrange
        let expectedArticles = Article.getArticles()
        mockRepository.articlesToReturn = expectedArticles
        
        // Act
        await viewModel.fetchArticles()
        
        // Assert
       await MainActor.run {
           XCTAssertEqual(viewModel.articles.count, expectedArticles.count)
           XCTAssertEqual(viewModel.articles[0].title, expectedArticles[0].title)
           XCTAssertFalse(viewModel.isLoading)
           XCTAssertNil(viewModel.errorMessage)
       }
    }
    
    func testFetchArticlesFailure() async {
        // Arrange
        mockRepository.shouldReturnError = true
          
        // Act
        await viewModel.fetchArticles()
          
        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.articles.isEmpty)
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.errorMessage, "Failed to load articles: Mock error")
        }
    }
    
    func testFetchArticlesLoadingState() async {
        // Act
        let fetchTask = Task { await viewModel.fetchArticles() }
        
        // Yield control to allow any pending updates
        await Task.yield()
        
        // Assert loading state is true before completion
        await MainActor.run {
            XCTAssertTrue(viewModel.isLoading, "Loading state should be true while fetching articles.")
        }
        
        // Wait for the task to complete
        await fetchTask.value
        
        // Assert loading state is false after completion
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading, "Loading state should be false after fetching articles.")
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
