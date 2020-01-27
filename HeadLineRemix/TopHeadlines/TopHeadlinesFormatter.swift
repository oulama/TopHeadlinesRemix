//
//  TopHeadlinesFormater.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

struct TopHeadlinesDetailViewData {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var publishedAt: String?
    init(article: Article) {
        author = article.author
        title = article.title
        description = article.description
        url = article.urlToImage
        publishedAt = article.publishedAt?.dateFormatter(from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "EEEE, MMM d, yyyy")
    }
}

typealias TopHeadlinesViewData = [TopHeadlinesDetailViewData]

class TopHeadlinesFormatter {
    func prepareData(articles: [Article]) -> TopHeadlinesViewData{
        var topHeadlinesViewData: TopHeadlinesViewData = []
        for article in articles{
            let topHeadlinesDetailViewData = TopHeadlinesDetailViewData(article: article)
            topHeadlinesViewData.append(topHeadlinesDetailViewData)
        }
        return topHeadlinesViewData
    }
}
