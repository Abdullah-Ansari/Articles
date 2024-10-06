//
//  ArticleRowView.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 06/10/24.
//

import SwiftUI

struct ArticleRowView: View {
    
    let article: Article
    
    var body: some View {
        HStack {
            articleImage
            articleDescription
        }
        .padding()
    }
    
    private var articleImage: some View {
        AsyncImage(url: article.imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 60, height: 60)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .clipped()
            case .failure(_):
                Image(systemName: "photo.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var articleDescription: some View {
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
    }
}

