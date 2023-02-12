//
//  ArticleCell.swift
//  FluxExample
//
//  Created by artembolotov on 12.02.2023.
//

import SwiftUI

struct ArticleCell: View {
    
    var article: Article
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(article.title ?? "")
                    .font(.headline)
                    .padding([.top, .bottom])
                Text(article.summary ?? "")
                    .font(.body)
                HStack {
                    Spacer()
                    Text(article.publishedAtPrettyDate ?? "")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top)
                }
            }
        }
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: Article.testArticle)
            .previewLayout(.fixed(width: 300, height: 170))
    }
}
