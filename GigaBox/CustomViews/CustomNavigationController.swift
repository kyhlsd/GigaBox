//
//  CustomNavigationController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        navigationBar.tintColor = .customGreen
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
    }
}
