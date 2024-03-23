//
//  BreakingNewsSection.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import UIKit

protocol BreakingNewsSectionDelegate: AnyObject {
    func breakingNewsSection(_ section: BreakingNewsSection, didSelect item: Article)
    func breakingNewsSeeAllButtonTapped(_ section: BreakingNewsSection, items: [Article], title: String)
}

class BreakingNewsSection: SectionsLayout {
    
    typealias ItemsType = Article
    
    var items: [ItemsType] = []
    
    var sectionHeaderTitle: String
    
    weak var delegate: BreakingNewsSectionDelegate?
    
    init(items: [ItemsType], delegate: BreakingNewsSectionDelegate, sectionHeaderTitle: String) {
        self.items = items
        self.delegate = delegate
        self.sectionHeaderTitle = sectionHeaderTitle
    }
    
    func numberOfItems() -> Int {
        return 6
    }
    
    func sectionLayout(
        _ collectionView: UICollectionView,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let header = createHeader()
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
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
        guard let cell: BreakingNewsCollectionViewCell = collectionView.dequeue(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(new: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        delegate?.breakingNewsSection(self, didSelect: item)
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
        header.setupHeaderButtonTitle(buttonTitle: "more")
        header.setupHeaderCount(count: "\(items.count - 6)")
        header.delegate = self
        return header
    }
    
    func registerCell(in collectionView: UICollectionView) {
        collectionView.registerNib(BreakingNewsCollectionViewCell.self)
    }
    
    func registerSupplementaryView(in collectionView: UICollectionView) {
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: HeaderCollectionReusableView.elementKind,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }
    
    func registerDecorationView(layout: UICollectionViewLayout) {
        
    }
}

extension BreakingNewsSection: HeaderCollectionReusableViewDelegate {
    func headerCollectionReusableViewButtonTapped() {
        delegate?.breakingNewsSeeAllButtonTapped(self, items: items, title: sectionHeaderTitle)
    }
}
