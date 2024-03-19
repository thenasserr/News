//
//  NewsModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 19/03/2024.
//

import Foundation

struct NewsModelResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
struct Source: Codable {
    let name: String
}
