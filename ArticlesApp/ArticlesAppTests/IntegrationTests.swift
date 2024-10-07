//
//  IntegrationTests.swift
//  ArticlesAppTests
//
//  Created by Abdullah Ansari on 06/10/24.
//

import XCTest
@testable import ArticlesApp

final class IntegrationTests: XCTestCase {

    var viewModel: ArticlesViewModel!
    var repository: ArticleRepository!
    var networkService: NetworkService!
    
    @MainActor 
    override func setUp() {
        networkService = NetworkService()
        repository = ArticleRepository(networkService: networkService)
        viewModel = ArticlesViewModel(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        networkService = nil
        viewModel = nil
    }
    
    func testFetchArticlesFromServerSuccessful() async {
        
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
            XCTAssertNil(viewModel.errorMessage, "Error message is nil when articles fetched successfully.")
        }
    }

}
