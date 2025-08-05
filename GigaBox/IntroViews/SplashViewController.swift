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
            let navigationController = UINavigationController(rootViewController: OnboardingViewController())
            navigationController.navigationBar.tintColor = .customGreen
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                DispatchQueue.main.async {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                        window.rootViewController = navigationController
                    }
                }
            }
        } else {
            let navigationController = UINavigationController(rootViewController: CinemaHomeViewController())
            navigationController.navigationBar.tintColor = .customGreen
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
            navigationController.tabBarItem = UITabBarItem(title: "CINEMA", image: UIImage(systemName: "popcorn"), tag: 0)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [navigationController]
            
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.selected.iconColor = .customGreen
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.customGreen]
            appearance.stackedLayoutAppearance.normal.iconColor = .customLightGray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.customLightGray]
            appearance.backgroundColor = .customBlack
            appearance.shadowColor = .customLightGray
            
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                DispatchQueue.main.async {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                        window.rootViewController = tabBarController
                    }
                }
            }
        }
    }
}
