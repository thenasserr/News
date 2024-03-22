//
//  SavedViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 22/03/2024.
//

import Foundation
import Combine

class SavedViewModel {
    
    // MARK: - Properties
    var cancellable = Set<AnyCancellable>()
    var sections: [any SectionsLayout] = []
    var news: [Article] = []
    var coordinator: SavedCoordinatorProtocol
    var reloadData: (() -> Void)?
    // MARK: - Initializer
    init(coordinator: SavedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func getSection() -> [any SectionsLayout] {
        let section = AllNewsSection(items: news, delegate: self, sectionHeaderTitle: "")
        PTabBarViewModel.shared.$bookMarks.sink { article in
            section.items = article.reversed()
            self.reloadData?()
        }.store(in: &cancellable)
        sections = [section]
        return sections
    }
}

extension SavedViewModel: AllNewsSectionDelegate {
    func allNewsSection(_ section: AllNewsSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
    }
}
