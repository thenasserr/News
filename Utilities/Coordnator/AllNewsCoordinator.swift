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
    func showTabBar()
    func hideTabBar()
}

class AllNewsCoordinator: AllNewsCoordinatorProtocol {
    var router: Router
    var tabBarCoordinator: TabBarCoordinator
    
    init(router: Router, tabBarCoordinator: TabBarCoordinator) {
        self.router = router
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func start() {
        
    }
    
    func showTabBar() {
        
    }
    
    func hideTabBar() {
        
    }
    
    func showAllNews(news: [Article], title: String) {
        let viewModel = AllNewsViewModel(news: news, sectionTitle: title, coordinator: self)
        let viewController = AllNewsViewController(viewModel: viewModel)
        router.push(viewController)
    }
    
    func showDetails(new: Article) {
        let coordinator = NewsDetailsCoordinator(router: router, tabBarCoordinator: tabBarCoordinator)
        coordinator.showDetails(new: new)
    }
}
