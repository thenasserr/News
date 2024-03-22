//
//  NotificationsUseCase.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import Foundation

protocol NotificationsUseCaseProtocol {
    func getSectionsLayout(delegate: NotificationsSectionDelegate) async throws -> [any SectionsLayout]
}

class NotificationsUseCase: NotificationsUseCaseProtocol {
    
    // MARK: - Properties
    private let newsAPI: NewsAPI
    
    // MARK: - Initialization
    init(newsAPI: NewsAPI = NewsAPIService()) {
        self.newsAPI = newsAPI
    }

    func getSectionsLayout(delegate: NotificationsSectionDelegate) async throws -> [any SectionsLayout] {
        let notifications = try await newsAPI.notifications()
        var sections: [any SectionsLayout] = []
        
        if let notifications = notifications?.articles {
            let layout = NotificationsSection(items: notifications, delegate: delegate, sectionHeaderTitle: "")
            sections.append(layout)
        }
        return sections
    }
}
