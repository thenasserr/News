//
//  TabBarItem.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 01/03/2024.
//

import UIKit
import MakeConstraints

class PTabBarItem: UIView {
    
    // MARK: - subViews
    private let stackView: UIStackView = UIStackView()
    private let iconView = UIView()
    public let iconImageView = UIImageView()
    
    // MARK: - Properties
    private var widthConstraint: NSLayoutConstraint?
    private let _height: CGFloat = 40
    private let _width: CGFloat = 100
    
    let item: UITabBarItem
    init(item: UITabBarItem) {
        self.item = item
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - setup subviews
    private func setup() {
        tag = item.tag
        setupStackView()
        setupIconView()
        setupIconImageView()
        addSubViews()
        select()
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
    }
    
    private func setupIconView() {
        iconView.equalSizeConstraints(_height)
        iconView.layer.cornerRadius = 20
    }
    
    private func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - add subviews
    private func addSubViews() {
        heightConstraints(_height)
        
        // add stackView
        addSubview(stackView)
        stackView.fillSuperview()
        
        // add icon, ImageView
        stackView.addArrangedSubview(iconView)
        iconView.addSubview(iconImageView)
        iconImageView.centerInSuperview(size: .init(width: 25, height: 25))
    }
    
    // MARK: - Public Methods
    public func select() {
        backgroundColor = .clear
        iconView.tintColor = .black
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.iconImageView.image = self?.item.selectedImage
            self?.iconView.backgroundColor = .nsecondarycolor
            self?.superview?.layoutIfNeeded()
        }
    }
    
    public func unSelect() {
        backgroundColor = .clear
        iconView.tintColor = .gray
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.iconImageView.image = self?.item.image
            self?.iconView.backgroundColor = .clear
            self?.superview?.layoutIfNeeded()
        }
    }
}
