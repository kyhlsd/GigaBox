//
//  CustomNavigationController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        navigationBar.tintColor = .customGreen
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
    }
}
