//
//  SearchUseCase.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 23/03/2024.
//

import Foundation

protocol SearchUseCaseProtocol {
    func search(with query: String) async throws -> NewsModelResponse?
}

class SearchUseCase: SearchUseCaseProtocol {
    // MARK: - Properties
    private let newsAPI: NewsAPI
    
    // MARK: - Initialization
    init(newsAPI: NewsAPI = NewsAPIService()) {
        self.newsAPI = newsAPI
    }
    
    func search(with query: String) async throws -> NewsModelResponse? {
        try await newsAPI.search(query: query)
    }
}
