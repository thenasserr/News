//
//  SearchResultsViewController.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 23/03/2024.
//

import UIKit

protocol SearchResultsProtocol {
    func searchResult(_ collectionView: UICollectionView, didSelect item: Article)
}

class SearchResultsViewController: UICollectionViewController {
    
    // MARK: - Properties
    var news: [Article] = []
    var viewModel: SearchResultViewModel
    
    // MARK: - Initializers
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Configuration
    //
    /// Configures the collection view properties.
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(AllNewsCollectionViewCell.self)
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    // MARK: - Compositional Layout
    //
    /// Creates a compositional layout for the collection view.
    /// - Returns: A UICollectionViewCompositionalLayout object.
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let height: CGFloat = 170
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets.bottom = 20
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AllNewsCollectionViewCell = collectionView.dequeue(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(new: news[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = news[indexPath.row]
        viewModel.showDetails(new: item)
    }
}
