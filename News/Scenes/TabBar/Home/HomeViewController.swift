//
//  HomeViewController.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 18/03/2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let request = APIRequest(endpoint: .topHeadlines, query: nil)
        APIService.shared.fetchNews(request: request, type: NewsModelResponse.self)
            .sink { _ in
                // Handle completion
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cancellables)
    }
}
