//
//  AllNewsCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import Foundation

protocol AllNewsCoordinatorProtocol: Coordinator {
    func showAllNews(news: [Article], title: String)
    func showDetails(new: Article)
}

class AllNewsCoordinator: AllNewsCoordinatorProtocol {
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
    
    func showAllNews(news: [Article], title: String) {
        let viewModel = AllNewsViewModel(news: news, sectionTitle: title, coordinator: self)
        let viewController = AllNewsViewController(viewModel: viewModel)
        router.push(viewController)
    }
    
    func showDetails(new: Article) {
        let viewController = NewViewController(news: new)
        router.push(viewController)
    }
}
