//
//  News.swift
//  MindEase
//
//  Created by Ricky Primayuda Putra on 22/05/25.
//

import Foundation

struct NewsResponse: Codable {
    var articles: [News]
}

struct News: Codable {
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
}
