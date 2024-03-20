//
//  TabBarCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import UIKit

protocol TabBarCoordinatorProtocol: Coordinator {
    func showTabBar()
    func hideTabBar()
    func showHome()
    func showUpcoming()
    func showSearch()
    func showDownload()
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    
    let viewModel: PTabBarViewModelInterface = PTabBarViewModel.shared
    let router: Router
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        router.navigationController.navigationBar.isHidden = true
        viewModel.viewControllers = [
            homeViewController(),
            upcomingViewController(),
            searchViewController(),
            downloadViewController()
        ]
        let viewControler = PTabBarViewController(viewModel: viewModel)
        router.push(viewControler)
    }
    
    func showTabBar() {
        self.viewModel.tabBarIsHidden = false
    }
    
    func hideTabBar() {
        viewModel.tabBarIsHidden = true
    }
    
    func showHome() {
        viewModel.selectedTab = .home
    }
    
    func showUpcoming() {
        
    }

    func showSearch() {
        
    }
    
    func showDownload() {
        
    }
    
    private func homeViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let router = AppRouter(navigationController: navigationController)
        let coordinator = HomeCoordinator(router: router, tabBarCoordinator: self)
        coordinator.start()
        return navigationController
    }
    
    private func upcomingViewController() -> UIViewController {
        return UIViewController()
    }
    
    private func searchViewController() -> UIViewController {
        return UIViewController()
    }
    
    private func downloadViewController() -> UIViewController {
        return UIViewController()
    }
}
