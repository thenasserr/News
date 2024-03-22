//
//  TabBarType.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 01/03/2024.
//

import UIKit

enum PTabBarType: Int, CaseIterable, Hashable {
    case home = 0
    case saved
    case notifications
    case search
    case settings
    
    private var title: String {
        switch self {
            case .home: "Home"
            case .saved: "Favorite"
            case .notifications: "Notifications"
            case .search: "Cart"
            case .settings: "Profile"
        }
    }
    
    private var icon: UIImage? {
        switch self {
            case .home:
                return .home.withRenderingMode(.alwaysOriginal)
            case .saved:
                return .save.withRenderingMode(.alwaysOriginal)
            case .notifications:
                return .notif.withRenderingMode(.alwaysOriginal)
            case .search:
                return .search.withRenderingMode(.alwaysOriginal)
            case .settings:
                return .settings.withRenderingMode(.alwaysOriginal)
        }
    }
    
    var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: title, image: icon, selectedImage: icon)
        item.tag = self.rawValue
        return item
    }
}
