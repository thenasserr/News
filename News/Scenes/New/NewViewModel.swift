//
//  NewViewModel.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import Foundation

class NewViewModel {
    
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
     func addToBookMarks() {
        if PTabBarViewModel.shared.bookMarks.contains(where: { $0 == article }) {
            PTabBarViewModel.shared.bookMarks.removeAll(where: { $0 == article })
        } else {
            PTabBarViewModel.shared.bookMarks.append(article)
        }
    }
}
