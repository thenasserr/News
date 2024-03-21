//
//  PoliticsSection.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

protocol PoliticsSectionDelegate: AnyObject {
    func politicsSection(_ section: PoliticsSection, didSelect item: Article)
}

class PoliticsSection: SectionsLayout {
    typealias ItemsType = Article
    
    var items: [ItemsType] = []
    
    var sectionHeaderTitle: String
    
    weak var delegate: PoliticsSectionDelegate?
    init(items: [ItemsType], delegate: PoliticsSectionDelegate, sectionHeaderTitle: String) {
        self.items = items
        self.delegate = delegate
        self.sectionHeaderTitle = sectionHeaderTitle
    }
    
    func numberOfItems() -> Int {
        return 15
    }
    
    func sectionLayout(
        _ collectionView: UICollectionView,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        
        let height: CGFloat = 110.0
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets.bottom = 25
        
        // Header
        let header = createHeader()
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
        
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
        guard let cell: PoliticsCollectionViewCell = collectionView.dequeue(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(new: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.politicsSection(self, didSelect: item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                let downloadAction = UIAction(title: "Download",
                                              subtitle: nil,
                                              image: UIImage(systemName: "square.and.arrow.down"),
                                              identifier: nil,
                                              discoverabilityTitle: nil, state: .off) { _ in
                    print("Downloaded")
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        
        return config
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
        return header
    }
    
    func registerCell(in collectionView: UICollectionView) {
        collectionView.registerNib(PoliticsCollectionViewCell.self)
    }
    
    func registerSupplementaryView(in collectionView: UICollectionView) {
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: HeaderCollectionReusableView.elementKind,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }
    
    func registerDecorationView(layout: UICollectionViewLayout) {
        
    }
}
