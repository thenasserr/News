//
//  SceneDelegate.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 17/03/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        AppCoordinator.shared.makeWindow(from: windowScene)
        AppCoordinator.shared.start()
    }
}
