//
//  HomeFactory.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import Foundation

enum SectionsTypes {
    case breakingNews([Article])
    case explore([Explore])
    case tech([Article])
    case politics([Article])
}

class HomeFactory {
    func createSection(type: SectionsTypes, delegate: HomeSectionsDelegate, title: String) -> any SectionsLayout {
        switch type {
            
            case .breakingNews(let news):
                return BreakingNewsSection(items: news, delegate: delegate, sectionHeaderTitle: title)
            case .explore(let explore):
                return ExploreSection(items: explore, delegate: delegate, sectionHeaderTitle: title)
            case .tech(let news):
                return TechSection(items: news, delegate: delegate, sectionHeaderTitle: title)
            case .politics(let news):
                return PoliticsSection(items: news, delegate: delegate, sectionHeaderTitle: title)
        }
    }
}
