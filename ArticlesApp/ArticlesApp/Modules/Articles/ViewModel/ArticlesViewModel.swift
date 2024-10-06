//
//  ArticlesViewModel.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

@MainActor
class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var filteredArticles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""

    private let repository: ArticleRepositoryProtocol

    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
    }

    func fetchArticles() async {
        isLoading = true
        errorMessage = nil
        do {
            articles = try await repository.fetchArticles()
            filteredArticles = articles
        } catch {
            errorMessage = "Failed to load articles: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func filterArticles(by searchText: String) {
        if searchText.isEmpty {
            filteredArticles = articles
        } else {
            filteredArticles = articles.filter { ($0.title ?? "").contains(searchText) }
        }
    }
}
