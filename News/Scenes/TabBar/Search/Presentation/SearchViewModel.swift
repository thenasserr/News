//
//  SearchViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 23/03/2024.
//

import Foundation

class SearchViewModel {
    // MARK: - Properties
    let useCase: SearchUseCase
    private let coordinator: SearchCoordinatorProtocol

    init(useCase: SearchUseCase, coordinator: SearchCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func search(with query: String) async throws -> NewsModelResponse? {
        return try await useCase.search(with: query)
    }
    
    func viewWillAppear() {
        coordinator.showTabBar()
    }
}
