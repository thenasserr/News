//
//  AllNewsViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import Foundation

class AllNewsViewModel {
    
    // MARK: - Properties
    var sections: [any SectionsLayout] = []
    var news: [Article]
    var sectionTitle: String
    var coordinator: AllNewsCoordinatorProtocol
    
    // MARK: - Initializer
    init(news: [Article], sectionTitle: String, coordinator: AllNewsCoordinatorProtocol) {
        self.news = news
        self.sectionTitle = sectionTitle
        self.coordinator = coordinator
    }
    
    func getSection() -> [any SectionsLayout] {
        let section = AllNewsSection(items: news, delegate: self, sectionHeaderTitle: sectionTitle)
        sections = [section]
        return sections
    }
}

extension AllNewsViewModel: AllNewsSectionDelegate {
    func allNewsSection(_ section: AllNewsSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
    }
}
