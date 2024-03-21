//
//  TechSection.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

protocol TechSectionDelegate: AnyObject {
    func techSection(_ section: TechSection, didSelect item: Article)
}

class TechSection: SectionsLayout {
    
    typealias ItemsType = Article
    
    var items: [ItemsType] = []
    
    var sectionHeaderTitle: String
    
    weak var delegate: TechSectionDelegate?
    
    init(items: [ItemsType], delegate: TechSectionDelegate, sectionHeaderTitle: String) {
        self.items = items
        self.delegate = delegate
        self.sectionHeaderTitle = sectionHeaderTitle
    }
    
    func numberOfItems() -> Int {
        items.count
    }
    
    func sectionLayout(
        _ collectionView: UICollectionView,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        // Item
        let itemSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90),
                                               heightDimension: .estimated(230))
        
        let group =  NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                      subitem: item,
                                                      count: 3)
        group.interItemSpacing = .fixed(8)
        let header = createHeader()
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderCollectionReusableView.elementKind,
            alignment: .top
        )
        
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell: TechCollectionViewCell = collectionView.dequeue(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(new: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        delegate?.techSection(self, didSelect: item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? HeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        header.setupHeaderTitle(title: sectionHeaderTitle)
        header.setupHeaderButtonTitle(buttonTitle: "See All")
        return header
    }
    
    func registerCell(in collectionView: UICollectionView) {
        collectionView.registerNib(TechCollectionViewCell.self)
    }
    
    func registerSupplementaryView(in collectionView: UICollectionView) {
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: HeaderCollectionReusableView.elementKind,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }
    
    func registerDecorationView(layout: UICollectionViewLayout) {
        
    }
}
