//
//  CustomTabBarController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        configureAppearance()
    }
    
    private func configureViewControllers() {
        let cinemaNavController = CustomNavigationController(rootViewController: CinemaHomeViewController())
        cinemaNavController.tabBarItem = UITabBarItem(title: "CINEMA", image: UIImage(systemName: "popcorn"), tag: 0)
        let upCommingNavController = CustomNavigationController(rootViewController: UpCommingViewController())
        upCommingNavController.tabBarItem = UITabBarItem(title: "UPCOMMING", image: UIImage(systemName: "film.stack"), tag: 1)
        let settingNavController = CustomNavigationController(rootViewController: SettingViewController())
        settingNavController.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.circle"), tag: 2)
        
        viewControllers = [cinemaNavController, upCommingNavController, settingNavController]
    }
    
    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = .customGreen
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.customGreen]
        appearance.stackedLayoutAppearance.normal.iconColor = .customLightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.customLightGray]
        appearance.backgroundColor = .customBlack
        appearance.shadowColor = .customLightGray
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
