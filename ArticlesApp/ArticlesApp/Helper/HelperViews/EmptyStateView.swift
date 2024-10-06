//
//  EmptyStateView.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 06/10/24.
//

import SwiftUI

struct EmptyStateView: View {
    var imageName: String
    var title: String
    var imageSize: CGSize = CGSize(width: 100, height: 100)
    var foregroundColor: Color = .gray
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
                .foregroundColor(foregroundColor)
                .padding(.bottom, 10)
            
            Text(title)
                .font(.headline)
                .foregroundColor(foregroundColor)
            Spacer()
        }
        .padding()
    }
}

