//
//  SavedCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 22/03/2024.
//

import Foundation

protocol SavedCoordinatorProtocol: Coordinator {
    func showSaved()
    func showDetails(new: Article)
    func showTabBar()
    func hideTabBar()
}

class SavedCoordinator: SavedCoordinatorProtocol {
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
    
    func showSaved() {
        let viewModel = SavedViewModel(coordinator: self)
        let viewController = SavedViewController(viewModel: viewModel)
        router.push(viewController)
    }
    
    func showDetails(new: Article) {
        let viewModel = NewViewModel(article: new)
        let viewController = NewViewController(viewModel: viewModel)
        router.push(viewController)
    }
}
