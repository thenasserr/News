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
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
struct Source: Codable {
    let name: String
}

struct Explore: Codable {
    let title: String
    let image: String
}

extension Explore {
    static let mockData: [Explore] = [
        .init(title: "Politics", image: "explore/1"),
        .init(title: "Tech", image: "explore/2"),
        .init(title: "Sport", image: "explore/3"),
        .init(title: "Finance", image: "explore/4"),
        .init(title: "Business", image: "explore/5"),
        .init(title: "Fashion", image: "explore/6"),
        .init(title: "Health", image: "explore/7"),
        .init(title: "Crypto", image: "explore/8"),
        .init(title: "Entert", image: "explore/9")
    ]
}
