//
//  SearchCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 23/03/2024.
//

import UIKit

protocol SearchCoordinatorProtocol: Coordinator {
    func showSearch()
    func getSearchResultViewController() -> UISearchController
    func showDetails(new: Article)
    func showTabBar()
    func hideTabBar()
}

class SearchCoordinator: SearchCoordinatorProtocol {
    var router: Router
    var tabBarCoordinator: TabBarCoordinator
    
    init(router: Router, tabBarCoordinator: TabBarCoordinator) {
        self.router = router
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func start() {
        showSearch()
    }
    
    func showTabBar() {
        tabBarCoordinator.showTabBar()
    }
    
    func hideTabBar() {
        tabBarCoordinator.hideTabBar()
    }
    
    func showSearch() {
        let useCase = SearchUseCase()
        let viewModel = SearchViewModel(useCase: useCase, coordinator: self)
        let viewController = SearchViewController(viewModel: viewModel)
        router.push(viewController)
    }
    
    func getSearchResultViewController() -> UISearchController {
        let viewModel = SearchResultViewModel(coordinator: self)
        let controller = UISearchController(searchResultsController: SearchResultsViewController(viewModel: viewModel))
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }
    
    func showDetails(new: Article) {
        let coordinator = NewsDetailsCoordinator(router: router, tabBarCoordinator: tabBarCoordinator)
        coordinator.showDetails(new: new)
    }
}
