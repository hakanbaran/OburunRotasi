//
//  TabBarVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit
import Foundation


class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    let basketButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor(hex: "#248CB3")
        
        
        let image = UIImage(systemName: "basket")
        
        var scaledImage = image?.scaledToHalf()
        scaledImage = scaledImage?.withTintColor(.white)
        
//        button.imageView?.contentMode = .scaleAspectFit
        
        button.setImage(scaledImage, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .clear
        
        basketButton.frame = CGRect(x: Int(self.tabBar.bounds.width)-105, y: -35, width: 60, height: 60)

        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        
        addTabItems()
    }
    
    override func loadView() {
        super.loadView()
        tabBar.addSubview(basketButton)
        setupCustomTabBar()
    }
    
    func addTabItems() {
        
        let homeVC = HomeVC()
        let favoriteVC = FavoriteVC()
        let basketVC = BasketVC()
        let profileVC = ProfileVC()
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        favoriteVC.navigationItem.largeTitleDisplayMode = .always
        basketVC.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationItem.largeTitleDisplayMode = .always
        
        let navHome = UINavigationController(rootViewController: homeVC)
        let navFavorite = UINavigationController(rootViewController: favoriteVC)
        let navBasket = UINavigationController(rootViewController: basketVC)
        let navProfile = UINavigationController(rootViewController: profileVC)
        
        navHome.tabBarItem = UITabBarItem(title: "Ana Sayfa", image: UIImage(systemName: "house"), tag: 1)
        navFavorite.tabBarItem = UITabBarItem(title: "Favoriler", image: UIImage(systemName: "heart"), tag: 2)
        navBasket.tabBarItem = UITabBarItem(title: "Sepetim", image: UIImage(systemName: "basket"), tag: 3)
        navProfile.tabBarItem = UITabBarItem(title: "Ayarlar", image: UIImage(systemName: "gear"), tag: 4)
        setViewControllers([navHome,navFavorite,navBasket, navProfile], animated: true)
        
    }
    
    func setupCustomTabBar() {
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = UIColor(hex: "#162544").cgColor
        
        shape.shadowColor = UIColor.white.cgColor
        shape.shadowOffset = CGSize(width: 0, height: 0)
        shape.shadowOpacity = 0.5
        shape.shadowRadius = 3
        shape.cornerRadius = 15
        shape.borderWidth = 0.2
        shape.borderColor = UIColor.darkGray.cgColor
        
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor.white
    }
    
    func getPathForTabBar() -> UIBezierPath {
            let frameWidth = self.tabBar.bounds.width
            let frameHeight = self.tabBar.bounds.height + 40
            let holeWidth = 150
            let holeHeight = 50
            let leftXUntilHole = Int(frameWidth)-150
            
            let path : UIBezierPath = UIBezierPath()
        
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
            path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
            
            path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
            
            path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0))
            path.addLine(to: CGPoint(x: frameWidth, y: 0))
            path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
            path.addLine(to: CGPoint(x: 0, y: frameHeight))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.close()
            return path
        }
    
    
    
    @objc func basketButtonTapped() {
        let basketVC = BasketVC()
        
        basketVC.overrideUserInterfaceStyle = .dark
        basketVC.modalPresentationStyle = .pageSheet
        self.present(basketVC, animated: true)
    }
    
    
}










