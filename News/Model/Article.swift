//
//  Article.swift
//  Good News
//
//  Created by PRIYANS on 18/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import Foundation

struct ArticleList: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
}

