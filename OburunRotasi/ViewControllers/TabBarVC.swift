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
        
        
        
        let homeVC = HomeVC()
        let favoriteVC = FavoriteVC()
        let profileVC = ProfileVC()
        
        
        view.backgroundColor = UIColor(hex: "#162544")
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        favoriteVC.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationItem.largeTitleDisplayMode = .always
        
        let navHome = UINavigationController(rootViewController: homeVC)
        let navFavorite = UINavigationController(rootViewController: favoriteVC)
        let navProfile = UINavigationController(rootViewController: profileVC)
        
        navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person"), tag: 1)
        navFavorite.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "person"), tag: 2)
        navProfile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        
        
        
        setViewControllers([navHome,navFavorite, navProfile], animated: true)
        
        
    }
    
    
}










