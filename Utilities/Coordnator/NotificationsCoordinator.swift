//
//  NotificationsCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

protocol NotificationsCoordinatorProtocol: Coordinator {
    func showNotifications()
    func showDetails(new: Article)
    func showTabBar()
    func hideTabBar()
}

class NotificationsCoordinator: NotificationsCoordinatorProtocol {
    
    var router: Router
    var tabBarCoordinator: TabBarCoordinator
    
    init(router: Router, tabBarCoordinator: TabBarCoordinator) {
        self.router = router
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func start() {
        showNotifications()
    }
    
    func showTabBar() {
        tabBarCoordinator.showTabBar()
    }
    
    func hideTabBar() {
        tabBarCoordinator.hideTabBar()
    }
    
    func showNotifications() {
        let useCase = NotificationsUseCase()
        let viewModel = NotificationsViewModel(useCase: useCase, coordinator: self)
        let vcc = NotificationsViewController(viewModel: viewModel)
        router.push(vcc)
    }
    
    func showDetails(new: Article) {
        let coordinator = NewsDetailsCoordinator(router: router)
        coordinator.showDetails(new: new)
    }
}
