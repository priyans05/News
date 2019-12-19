//
//  ArticleViewModel.swift
//  Good News
//
//  Created by PRIYANS on 18/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int)-> ArticleViewModel {
        return ArticleViewModel(articles[index])
    }
}

struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String {
        return article.title
    }
    var description: String {
        return article.description
    }
}
