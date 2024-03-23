//
//  SearchResultsViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 23/03/2024.
//

import Foundation

class SearchResultViewModel {
    let coordinator: SearchCoordinatorProtocol

    init(coordinator: SearchCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func showDetails(new: Article) {
        coordinator.showDetails(new: new)
    }
}
