//
//  TabBarAssembly.swift
//  CookRecipes
//
//  Created by Влад on 16.06.2022.
//

import Foundation
import UIKit

final class TabBarAssembly {

    func build() -> UITabBarController {
        let homeController = FeedsAssembly.createDetailsViewController()
        let savedController =  UINavigationController(
            rootViewController:
                SavedRecipesAssembly.createDetailsViewController()
        )
        let searchController = SearchAssembly.createDetailsViewController()

        let tabbar = UITabBarController()
        tabbar.tabBar.backgroundColor = .clear
        tabbar.setViewControllers([homeController, searchController,savedController], animated: true)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        savedController.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "book"), tag: 2)
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        tabbar.tabBar.tintColor = Colors.primary50.value
        tabbar.tabBar.unselectedItemTintColor = Colors.neutral40.value
        return tabbar
    }
}
