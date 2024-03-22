//
//  SavedViewController.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 22/03/2024.
//

import UIKit

class SavedViewController: UICollectionViewController {
    
    // MARK: - Properties
    var sections: [any SectionsLayout] = []
    var viewModel: SavedViewModel
    
    // MARK: - Initializers
    init(viewModel: SavedViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: .init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.bookmarks
        getSections()
        viewModel.reloadData = {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: - Private Methods
    private func getSections() {
        let section = viewModel.getSection()
        configureCollectionView(with: section)
    }
    
    private func show( _ error: Error) {
        print(error)
    }
    
    // MARK: - UI Configuration
    private func configureCollectionView(with sections: [any SectionsLayout]) {
        self.sections = sections
        sections.forEach { section in
            section.registerCell(in: self.collectionView)
            section.registerSupplementaryView(in: self.collectionView)
        }
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.reloadData()
    }
    
    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) in
            self.sections[sectionIndex].sectionLayout(self.collectionView, layoutEnvironment: layoutEnvironment)
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        sections[indexPath.section].collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].collectionView(collectionView, didSelectItemAt: indexPath)
    }
}
