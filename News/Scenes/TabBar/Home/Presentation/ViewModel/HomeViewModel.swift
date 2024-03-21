//
//  HomeViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

typealias HomeSectionsDelegate = BreakingNewsSectionDelegate & ExploreSectionDelegate & TechSectionDelegate & PoliticsSectionDelegate

class HomeViewModel {
    
    // MARK: - Properties
    private let useCase: HomeUseCase
    private let coordinator: HomeCoordinatorProtocol
    
    // MARK: - Initialization
    init(useCase: HomeUseCase, coordinator: HomeCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func getSections() async throws -> [any SectionsLayout] {
        return try await useCase.getSectionLayouts(delegate: self)
    }
    
    func viewWillAppear() {
        coordinator.showTabBar()
    }
}

// MARK: - HomeViewModel Sections Delegate Methods
extension HomeViewModel: HomeSectionsDelegate {
    func techNewsSeeAllButtonTapped(_ section: TechSection, items: [Article], title: String) {
        coordinator.showAllNews(news: items, title: title)
        coordinator.hideTabBar()
    }
    
    func politicsNewsSeeAllButtonTapped(_ section: PoliticsSection, items: [Article], title: String) {
        coordinator.showAllNews(news: items, title: title)
        coordinator.hideTabBar()
    }
    
    func breakingNewsSeeAllButtonTapped(_ section: BreakingNewsSection, items: [Article], title: String) {
        coordinator.showAllNews(news: items, title: title)
        coordinator.hideTabBar()
    }
    
    func politicsSection(_ section: PoliticsSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
        coordinator.hideTabBar()
    }
    
    func techSection(_ section: TechSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
        coordinator.hideTabBar()
    }
    
    func exploreSection(_ section: ExploreSection, didSelect item: Explore) {
        print(item)
    }
    
    func breakingNewsSection(_ section: BreakingNewsSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
        coordinator.hideTabBar()
    }
}
