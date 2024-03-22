//
//  NotificationsViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import Foundation

class NotificationsViewModel {
    // MARK: - Properties
    private let useCase: NotificationsUseCase
    private let coordinator: NotificationsCoordinatorProtocol
    
    // MARK: - Initialization
    init(useCase: NotificationsUseCase, coordinator: NotificationsCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func getSections() async throws -> [any SectionsLayout] {
        return try await useCase.getSectionsLayout(delegate: self)
    }
    
    func viewWillAppear() {
        coordinator.showTabBar()
    }
}

extension NotificationsViewModel: NotificationsSectionDelegate {
    func notificationsSection(_ section: NotificationsSection, didSelect item: Article) {
        coordinator.showDetails(new: item)
        coordinator.hideTabBar()
    }
}
