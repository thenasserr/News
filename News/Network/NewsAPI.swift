//
//  NewsAPI.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 19/03/2024.
//

import Foundation

protocol NewsAPI: BaseAPI {
    func topHeadLines() async throws -> NewsModelResponse?
    func techNews() async throws -> NewsModelResponse?
    func politicsNews() async throws -> NewsModelResponse?
    func notifications() async throws -> NewsModelResponse?
}

struct NewsAPIService: NewsAPI {
    func topHeadLines() async throws -> NewsModelResponse? {
        try await fetchNews(request: APIRequest(endpoint: .topHeadlines, query: nil), type: NewsModelResponse.self)
    }
    
    func techNews() async throws -> NewsModelResponse? {
        try await fetchNews(request: APIRequest(endpoint: .tech, query: nil), type: NewsModelResponse.self)
    }
    
    func politicsNews() async throws -> NewsModelResponse? {
        try await fetchNews(request: APIRequest(endpoint: .politics, query: nil), type: NewsModelResponse.self)
    }
    
    func notifications() async throws -> NewsModelResponse? {
        try await fetchNews(request: APIRequest(endpoint: .notifications, query: nil), type: NewsModelResponse.self)
    }
}
