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
            let layout = factory.createSection(type: .breakingNews(breakingNews), delegate: delegate, title: L10n.Home.breakingNews)
            sections.append(layout)
        }
        
        if let explore = Explore.mockData {
            let layout = factory.createSection(type: .explore(explore), delegate: delegate, title: L10n.Home.explore)
            sections.append(layout)
        }
        
        let techNews = try await newsAPI.techNews()
        if let techNews = techNews?.articles {
            let layout = factory.createSection(type: .tech(techNews), delegate: delegate, title: L10n.Home.tech)
            sections.append(layout)
        }
        
        let politicsNews = try await newsAPI.politicsNews()
        if let politicsNews = politicsNews?.articles {
            let layout = factory.createSection(type: .politics(politicsNews), delegate: delegate, title: L10n.Home.politics)
            sections.append(layout)
        }
        return sections
    }
}
