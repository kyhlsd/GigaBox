//
//  SplashViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import UIKit
import SnapKit

final class SplashViewController: IntroBaseViewController {
    
    private let nickname = UserDefaultManager.nickname
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.convertViewController()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        titleLabel.text = "GigaBox"
        subtitleLabel.text = nickname ?? "김영훈"
    }
    
    private func convertViewController() {
        if nickname == nil {
            let navigationController = CustomNavigationController(rootViewController: OnboardingViewController())
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                DispatchQueue.main.async {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                        window.rootViewController = navigationController
                    }
                }
            }
        } else {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = CustomTabBarController()
            }
        }
    }
}
