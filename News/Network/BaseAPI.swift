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
}

class APIService {
    static let shared = APIService()
    func fetchNews<T>(request: APIRequest, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        guard let url = request.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        print(urlRequest)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, _ in
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    throw Errors.invalidDecoding
                }
                return decodedData
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
