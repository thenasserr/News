//
//  WebViewCoordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 22/03/2024.
//

import Foundation

protocol WebViewCoordinatorProtocol: Coordinator {
    func showWebView(url: URLRequest)
}

class WebViewCoordinator: WebViewCoordinatorProtocol {
    
    var router: Router
    var tabBarCoordinator: TabBarCoordinator
    
    init(router: Router, tabBarCoordinator: TabBarCoordinator) {
        self.router = router
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    func start() {
        
    }
    
    func showWebView(url: URLRequest) {
        let viewController = WebViewController(url: url)
        router.push(viewController)
    }
}
