//
//  NewsDetailsCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

protocol NewsDetailsCoordinatorProtocol: Coordinator {
    func showDetails(new: Article)
}

class NewsDetailsCoordinator: NewsDetailsCoordinatorProtocol {
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
    
    func showDetails(new: Article) {
        let viewModel = NewViewModel(article: new)
        let viewController = NewViewController(viewModel: viewModel)
        router.push(viewController)
    }
}
