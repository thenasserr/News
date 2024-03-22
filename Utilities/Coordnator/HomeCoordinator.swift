//
//  HomeCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import UIKit

protocol HomeCoordinatorProtocol: Coordinator {
    func showHome()
    func showDetails(new: Article)
    func showAllNews(news: [Article], title: String)
    func showTabBar()
    func hideTabBar()
}

class HomeCoordinator: HomeCoordinatorProtocol {
    
    var router: Router
    var tabBarCoordinator: TabBarCoordinator
    
    init(router: Router, tabBarCoordinator: TabBarCoordinator) {
        self.router = router
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func start() {
        showHome()
    }
    
    func showTabBar() {
        tabBarCoordinator.showTabBar()
    }
    
    func hideTabBar() {
        tabBarCoordinator.hideTabBar()
    }
    
    func showHome() {
        let factory = HomeFactory()
        let useCase = HomeUseCase(factory: factory)
        let viewModel = HomeViewModel(useCase: useCase, coordinator: self)
        let vcc = HomeViewController(viewModel: viewModel)
        router.push(vcc)
    }
    
    func showDetails(new: Article) {
        let coordinator = NewsDetailsCoordinator(router: router, tabBarCoordinator: tabBarCoordinator)
        coordinator.showDetails(new: new)
    }
    
    func showAllNews(news: [Article], title: String) {
        let coordinator = AllNewsCoordinator(router: router, tabBarCoordinator: tabBarCoordinator)
        coordinator.showAllNews(news: news, title: title)
    }
}
