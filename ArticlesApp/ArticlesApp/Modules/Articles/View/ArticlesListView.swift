//
//  ArticlesListView.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import SwiftUI

struct ArticlesListView: View {
    
    @StateObject private var viewModel: ArticlesViewModel

    init() {
        _viewModel = StateObject(wrappedValue: ArticlesViewModel(repository: ArticleRepository(networkService: NetworkService())))
    }

    var body: some View {
        
        NavigationStack {
            VStack {
                searchBar()
                listOfArticles()
            }
            .navigationTitle("Articles")
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading Articles...")
                }
            }
        }
    }
    
    @ViewBuilder
    func searchBar() -> some View {
        HStack {
            TextField("Seach the articles..", text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { _, newText in
                    viewModel.filterArticles(by: newText)
                }
            Image(systemName: "magnifyingglass.circle")
                .frame(height: 40)
        }
        .disabled(viewModel.isLoading)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
       
    }
    
    @ViewBuilder
   func listOfArticles() -> some View {
       if viewModel.filteredArticles.isEmpty && !viewModel.isLoading {
           EmptyStateView(
            imageName: "doc.text.magnifyingglass",
            title: "No articles found"
           )
       } else {
           List(viewModel.filteredArticles, id: \.id) { article in
               NavigationLink(
                destination: ArticleDetailView(article: article)
               ) {
                   ArticleRowView(article: article)
               }
           }
           .listStyle(.plain)
       }
   }
}
