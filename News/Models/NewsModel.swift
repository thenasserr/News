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

struct Article: Codable, Equatable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
struct Source: Codable, Equatable {
    let name: String
}

struct Explore: Codable {
    let title: String
    let image: String
}

extension Explore {
    static let mockData: [Explore]? = [
        .init(title: "POLITICS", image: "explore/1"),
        .init(title: "TECH", image: "explore/2"),
        .init(title: "SPORTS", image: "explore/3"),
        .init(title: "FINANCE", image: "explore/4"),
        .init(title: "Business", image: "explore/5"),
        .init(title: "FASHION", image: "explore/6"),
        .init(title: "CINEMA", image: "explore/7"),
        .init(title: "GAMING", image: "explore/8"),
        .init(title: "ARTS", image: "explore/9")
    ]
}

enum NewsCategory {
    case politics
    case tech
    case sports
    case finance
    case cinema
    case fashion
    case art
}
