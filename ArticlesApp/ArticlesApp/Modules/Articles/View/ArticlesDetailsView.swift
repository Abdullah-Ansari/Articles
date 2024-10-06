//
//  ArticlesDetailsView.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                articleImageContent
                articleDescriptionContent
                Divider()
                fullArticleContent
            }
            .padding()
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var articleImageContent: some View {
        AsyncImage(url: article.imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .clipped()
            case .failure(_):
                Image(systemName: "photo.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private var articleDescriptionContent: some View {
        VStack(alignment: .leading) {
            Text(article.title ?? "")
                .font(.title3)
                .fontWeight(.bold)

            Text(article.abstract ?? "")
                .font(.headline)
                .foregroundColor(.gray)
           
            Label {
                Text(article.publishedDate ?? "")
                    .font(.body)
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private var fullArticleContent : some View {
        // Assuming you have a URL for the article content
        VStack(alignment: .leading) {
            if let url = article.articleURL {
                Link("Read Full Article", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }

            Text("This is where the article content would go.")
                .font(.body)
        }
       
    }
}

#Preview {
    ArticleDetailView(
        article: Article(
            uri: "",
            url: "",
            id: 0,
            assetID: 0,
            source: nil,
            publishedDate: "",
            updated: "",
            section: "",
            subsection: "",
            nytdsection: "",
            adxKeywords: "",
            title: "",
            abstract: "",
            byline: "",
            desFacet: [],
            orgFacet: [],
            perFacet: [],
            geoFacet: [],
            media: [],
            etaID: 0
        )
    )
}
