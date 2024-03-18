//
//  TabBarViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 01/03/2024.
//

import UIKit
import Combine

protocol PTabBarViewModelInterface: AnyObject {  
    var tabBarIsHidden: Bool { get set }
    var tabBarIsHiddenPublisher: Published<Bool>.Publisher { get }
    
    var selectedTab: PTabBarType { get set }
    var selectedTabPublisher: Published<PTabBarType>.Publisher { get }
    
    var viewControllers: [UIViewController] { get set }
}

class PTabBarViewModel: ObservableObject, PTabBarViewModelInterface {
    static let shared = PTabBarViewModel()
        
    @Published var tabBarIsHidden: Bool = false
    var tabBarIsHiddenPublisher: Published<Bool>.Publisher { $tabBarIsHidden }
    
    @Published var selectedTab: PTabBarType = .home
    var selectedTabPublisher: Published<PTabBarType>.Publisher { $selectedTab }
    
    var viewControllers: [UIViewController] = [HomeViewController()]
}
