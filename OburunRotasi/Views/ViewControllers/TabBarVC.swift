//
//  TabBarVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit

class TabBarVC: UITabBarController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeVC()
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        
        let navHome = UINavigationController(rootViewController: homeVC)
        
        navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person"), tag: 1)
        setViewControllers([navHome], animated: true)
    }
    

}
