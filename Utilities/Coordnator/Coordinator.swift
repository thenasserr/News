//
//  Coordinator.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 17/03/2024.
//

import UIKit

protocol Coordinator {
    var router: Router { get }
    
    func start()
}
