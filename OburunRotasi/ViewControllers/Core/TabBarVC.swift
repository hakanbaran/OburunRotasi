//
//  TabBarVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit



class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        let homeVC = HomeVC()
        let favoriteVC = FavoriteVC()
        let basketVC = BasketVC()
        let profileVC = ProfileVC()
        
        view.backgroundColor = UIColor(hex: "#162544")
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        favoriteVC.navigationItem.largeTitleDisplayMode = .always
        basketVC.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationItem.largeTitleDisplayMode = .always
        
        let navHome = UINavigationController(rootViewController: homeVC)
        let navFavorite = UINavigationController(rootViewController: favoriteVC)
        let navBasket = UINavigationController(rootViewController: basketVC)
        let navProfile = UINavigationController(rootViewController: profileVC)
        
        navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person"), tag: 1)
        navFavorite.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "person"), tag: 2)
        navBasket.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "person"), tag: 3)
        navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 4)
        setViewControllers([navHome,navFavorite,navBasket, navProfile], animated: true)
    }
}










