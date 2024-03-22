//
//  NewViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

class NewViewModel {
    
    var article: Article
    var coordinator: NewsDetailsCoordinatorProtocol
    
    init(article: Article, coordinator: NewsDetailsCoordinatorProtocol) {
        self.article = article
        self.coordinator = coordinator
    }
    
     func addToBookMarks() {
        if PTabBarViewModel.shared.bookMarks.contains(where: { $0 == article }) {
            PTabBarViewModel.shared.bookMarks.removeAll(where: { $0 == article })
        } else {
            PTabBarViewModel.shared.bookMarks.append(article)
        }
    }
    
    func webSiteLinkTapped() {
        guard let url = URL(string: article.url ?? "") else { return }
        let request = URLRequest(url: url)
        coordinator.showWebView(url: request)
    }
}
