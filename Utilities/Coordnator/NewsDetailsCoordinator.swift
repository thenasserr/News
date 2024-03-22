//
//  NewsDetailsCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

protocol NewsDetailsCoordinatorProtocol: Coordinator {
    func showDetails(new: Article)
    func showWebView(url: URLRequest)
}

class NewsDetailsCoordinator: NewsDetailsCoordinatorProtocol {
    var router: Router
    var tabBarCoordinator: TabBarCoordinator

    init(router: Router, tabBarCoordinator: TabBarCoordinator) {
        self.router = router
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func start() {
        
    }
    
    func showDetails(new: Article) {
        let viewModel = NewViewModel(article: new, coordinator: self)
        let viewController = NewViewController(viewModel: viewModel)
        router.push(viewController)
    }
    
    func showWebView(url: URLRequest) {
       let coordinator = WebViewCoordinator(router: router, tabBarCoordinator: tabBarCoordinator)
        coordinator.showWebView(url: url)
    }
}
