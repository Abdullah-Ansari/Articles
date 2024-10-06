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

