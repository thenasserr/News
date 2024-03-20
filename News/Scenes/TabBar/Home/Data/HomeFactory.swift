//
//  HomeFactory.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

enum SectionsTypes {
    case trendingMovies([Article])
    case explore([Explore])
    case tech([Article])
}

class HomeFactory {
    func createSection(type: SectionsTypes, delegate: HomeSectionsDelegate, title: String) -> any SectionsLayout {
        switch type {
            
            case .trendingMovies(let news):
                return BreakingNewsSection(items: news, delegate: delegate, sectionHeaderTitle: title)
            case .explore(let explore):
                return ExploreSection(items: explore, delegate: delegate, sectionHeaderTitle: title)
            case .tech(let news):
                return TechSection(items: news, delegate: delegate, sectionHeaderTitle: title)
        }
    }
}
