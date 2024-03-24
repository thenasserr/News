//
//  SearchViewViewController.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 23/03/2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchViewController: UICollectionViewController {

    var viewModel: SearchViewModel
        
    private let searchController: UISearchController
    
    // MARK: - Initializers
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        searchController = viewModel.getSearchResultController()
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.search
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 1,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        Task {
            do {
                let news = try await viewModel.search(with: query)
                resultsController.news = news?.articles ?? []
                resultsController.collectionView.reloadData()
            } catch {
                print("errorr")
            }
        }
    }
}
