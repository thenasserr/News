//
//  BaseAPI.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 18/03/2024.
//

import Foundation
import Combine

enum Errors: Error {
    case invalidDecoding
    case invalidQuery
    case invalidURL
    case failedToGetData
    case failedToCreateRequest
}

protocol BaseAPI {
    func fetchNews<T>(request: APIRequest, type: T.Type) async throws -> T where T: Decodable
    func search<T>(request: APIRequest, type: T.Type) async throws -> T where T: Decodable
}

extension BaseAPI {

    func fetchNews<T>(request: APIRequest, type: T.Type) async throws -> T where T: Decodable {
        guard let url = request.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        print(urlRequest)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw Errors.invalidDecoding
        }
        return decodedData
    }
    
    func search<T>(request: APIRequest, type: T.Type) async throws -> T where T: Decodable {
        guard let url = request.searchUrl else {
            throw Errors.failedToCreateRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        print(urlRequest)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let result = try JSONDecoder().decode(type.self, from: data)
            return result
        } catch {
            throw Errors.failedToGetData
        }
    }
}
