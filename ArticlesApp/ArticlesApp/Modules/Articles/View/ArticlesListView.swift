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
        _viewModel = StateObject(wrappedValue: ArticlesViewModel(repository: ArticleRepository()))
    }

    var body: some View {
        NavigationStack {
            List(viewModel.articles, id:\.id) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    ArticleRowView(article: article)
                }
            }
            .navigationTitle("NY Times Most Popular")
            .onAppear {
                Task {
                    await viewModel.fetchArticles()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading Articles...")
                }
            }
//            .alert(item: $viewModel.errorMessage) { message in
//                Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("OK")))
//            }
        }
    }
}

struct ArticleRowView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title ?? "")
                .font(.headline)
                .padding(.bottom, 2)

            Text(article.abstract ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(article.publishedDate ?? "")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

