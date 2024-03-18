//
//  TabBar.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 01/03/2024.
//

import UIKit
import MakeConstraints

protocol PTabBarDelegate: AnyObject {
    // called when a new view is selected by the user (but not programmatically)
    func pTabBar(_ pTabBar: PTabBar, didSelect emItem: PTabBarItem)
}

class PTabBar: UIView {
    
    // MARK: - subviews
    private let stackView: UIStackView = UIStackView()
    private var tapGestures: [UITapGestureRecognizer] = []
    
    // MARK: - properties
    private(set) var pItems: [PTabBarItem] = []
    weak private(set) var selectedItem: PTabBarItem?
    
    weak var delegate: PTabBarDelegate?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public func selectItem(at index: Int) {
        let item = pItems[index]
        self.select(item)
    }
    
    // MARK: - setup subviews
    private func setup() {
        backgroundColor = .white
        heightConstraints(46 + (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 20))
        setupStackView()
        addShadow()
    }
    
    private func addShadow() {
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        let bottomPadding = (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 0) / 2
        let padding = UIEdgeInsets(top: 0, left: 32, bottom: bottomPadding, right: 32)
        stackView.fillSuperview(padding: padding)
    }
    
    public func setItems(_ items: [UITabBarItem]) {
        for item in items {
            let tabBarItem = PTabBarItem(item: item)
            stackView.addArrangedSubview(tabBarItem)
            pItems.append(tabBarItem)
        }
        select(pItems.first)
        addTapGestures()
    }
    
    private func addTapGestures() {
        stackView.arrangedSubviews.forEach { view in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
            view.addGestureRecognizer(tapGesture)
        }
    }

    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        guard let pItem = sender.view as? PTabBarItem else {
            return
        }
        select(pItem)
        delegate?.pTabBar(self, didSelect: pItem)
    }
    
    private func select(_ item: PTabBarItem?) {
        selectedItem = item
        for pItem in pItems {
            if item === pItem {
                pItem.select()
            } else {
                pItem.unSelect()
            }
        }
    }
}
