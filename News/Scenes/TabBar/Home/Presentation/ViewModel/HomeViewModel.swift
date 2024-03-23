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
    func exploreSection(_ section: ExploreSection, didSelect item: Explore, at indexPath: IndexPath) {
        Task {
            do {
                var news: [Article]?
                switch indexPath.row {
                    case 0:
                        news = try await fetchNews(category: .politics)
                    case 1:
                        news = try await fetchNews(category: .tech)
                    case 2:
                        news = try await fetchNews(category: .sports)
                    case 3:
                        news = try await fetchNews(category: .finance)
                    case 5:
                        news = try await fetchNews(category: .fashion)
                    case 6:
                        news = try await fetchNews(category: .cinema)
                    case 8:
                        news = try await fetchNews(category: .art)
                    default:
                        break
                }
                DispatchQueue.main.async {
                    self.coordinator.showAllNews(news: news ?? [], title: item.title)
                    self.coordinator.hideTabBar()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
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
    
    func breakingNewsSection(_ section: BreakingNewsSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
        coordinator.hideTabBar()
    }
    
    private func fetchNews(category: NewsCategory) async throws -> [Article]? {
        switch category {
            case .politics:
                return (try await useCase.getPoliticsNews())?.articles
            case .tech:
                return (try await useCase.getTechNews())?.articles
            case .sports:
                return (try await useCase.getSportsNews())?.articles
            case .finance:
                return (try await useCase.getFinanceNews())?.articles
            case .cinema:
                return (try await useCase.getCinemaNews())?.articles
            case .fashion:
                return (try await useCase.getFashionNews())?.articles
            case .art:
                return (try await useCase.getArtsNews())?.articles
        }
    }
}
