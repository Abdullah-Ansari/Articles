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
                Text(article.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(article.abstract ?? "")
                    .font(.title2)
                    .foregroundColor(.gray)

                Text(article.publishedDate ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)

                Divider()

                // Assuming you have a URL for the article content
                if let urlString = article.url, !urlString.isEmpty, let url = URL(string: urlString) {
                    Link("Read Full Article", destination: url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }

                // Add any additional content you want to display
                // For example, a description or body content if available
                Text("This is where the article content would go.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
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
