//
//  HomeUseCase.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getSectionLayouts(delegate: HomeSectionsDelegate) async throws -> [any SectionsLayout]
}

class HomeUseCase: HomeUseCaseProtocol {
    
    // MARK: - Properties
    private let newsAPI: NewsAPI
    private let factory: HomeFactory
    
    // MARK: - Initialization
    init(newsAPI: NewsAPI = NewsAPIService(), factory: HomeFactory) {
        self.newsAPI = newsAPI
        self.factory = factory
    }
    
    func getSectionLayouts(delegate: HomeSectionsDelegate) async throws -> [any SectionsLayout] {
        let breakingNews = try await newsAPI.topHeadLines()
        var sections: [any SectionsLayout] = []
        
        if let breakingNews = breakingNews?.articles {
            let layout = factory.createSection(type: .trendingMovies(breakingNews), delegate: delegate, title: L10n.Home.breakingNews)
            sections.append(layout)
        }
        return sections
    }
}
