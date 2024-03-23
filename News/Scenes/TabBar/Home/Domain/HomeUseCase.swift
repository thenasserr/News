//
//  HomeUseCase.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getSectionLayouts(delegate: HomeSectionsDelegate) async throws -> [any SectionsLayout]
    func getPoliticsNews() async throws -> NewsModelResponse?
    func getTechNews() async throws -> NewsModelResponse?
    func getSportsNews() async throws -> NewsModelResponse?
    func getFinanceNews() async throws -> NewsModelResponse?
    func getCinemaNews() async throws -> NewsModelResponse?
    func getFashionNews() async throws -> NewsModelResponse?
    func getArtsNews() async throws -> NewsModelResponse?
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
    
    func getPoliticsNews() async throws -> NewsModelResponse? {
        try await newsAPI.politicsNews()
    }
    
    func getTechNews() async throws -> NewsModelResponse? {
        try await newsAPI.techNews()
    }
    
    func getSportsNews() async throws -> NewsModelResponse? {
        try await newsAPI.sportsNews()
    }
    
    func getFinanceNews() async throws -> NewsModelResponse? {
        try await newsAPI.notifications()
    }
    
    func getCinemaNews() async throws -> NewsModelResponse? {
        try await newsAPI.cinemaNews()
    }
    
    func getFashionNews() async throws -> NewsModelResponse? {
        try await newsAPI.fashionNews()
    }
    
    func getArtsNews() async throws -> NewsModelResponse? {
        try await newsAPI.artNews()
    }
}
