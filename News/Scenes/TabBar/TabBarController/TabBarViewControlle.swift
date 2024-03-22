//
//  TabBarViewControlle.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 01/03/2024.
//

import UIKit
import Combine
import MakeConstraints

class PTabBarViewController: UITabBarController {
    let pTabBar = News.PTabBar()
    
    var cancellable = Set<AnyCancellable>()
    var tabBarConstraints: AnchoredConstraints?
    
    let viewModel: PTabBarViewModelInterface
    init(viewModel: PTabBarViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        viewControllers = viewModel.viewControllers
        setupFTapBar()
        
        viewModel.selectedTabPublisher.sink { [weak self] type in
            self?.selectedIndex = type.rawValue
            self?.pTabBar.selectItem(at: type.rawValue)
        }
        .store(in: &cancellable)
        
        viewModel.tabBarIsHiddenPublisher
            .sink { [self] hidden in
                self.tabBarConstraints?.bottom?.constant = hidden ? 100 : 0
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                    
                    if !hidden {
                        self.pTabBar.isHidden = hidden
                    }
                } completion: { _ in
                    self.pTabBar.isHidden = hidden
                }
                
            }
            .store(in: &cancellable)
    }
    
    private func setupFTapBar() {
        pTabBar.delegate = self
        view.addSubview(pTabBar)
        pTabBar.fillXSuperView(paddingLeft: 15, paddingRight: 15)
        tabBarConstraints = pTabBar.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        pTabBar.setItems(PTabBarType.allCases.map { $0.tabBarItem })
    }
}

extension PTabBarViewController: PTabBarDelegate {
    func pTabBar(_ pTabBar: PTabBar, didSelect pItem: PTabBarItem) {
        selectedIndex = pItem.tag
        viewModel.selectedTab = PTabBarType(rawValue: pItem.tag) ?? .home
    }
}

extension UIView {
    func makeConstraintss(bottomAnchor: NSLayoutYAxisAnchor, paddingBottom: CGFloat) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingBottom)
            // Add other constraints as needed
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
