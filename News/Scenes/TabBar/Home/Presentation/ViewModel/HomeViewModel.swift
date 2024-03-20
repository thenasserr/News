//
//  HomeViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

typealias HomeSectionsDelegate = BreakingNewsSectionDelegate & ExploreSectionDelegate

class HomeViewModel {
    
    // MARK: - Properties
    private let useCase: HomeUseCase
    
    // MARK: - Initialization
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getSections() async throws -> [any SectionsLayout] {
        return try await useCase.getSectionLayouts(delegate: self)
    }
}

// MARK: - HomeViewModel Sections Delegate Methods
extension HomeViewModel: HomeSectionsDelegate {
    func exploreSection(_ section: ExploreSection, didSelect item: Explore) {
        print(item)
    }
    
    func breakingNewsSection(_ section: BreakingNewsSection, didSelect item: Article) {
        print(item)
    }
}
