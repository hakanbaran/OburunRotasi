//
//  ViewController.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit
import SDWebImage


enum BrowseSectionType {
    case indirim // 1
    case kategori // 2
}




class HomeVC: UIViewController {
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let appIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.backgroundColor = .red
        return image
    }()
    
    private let appTittle: UILabel = {
        let label = UILabel()
        label.text = "Oburun Rotası"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let adressPin : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Teslimat Adresi İş Yeri"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let searcBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Yemek Arama..."
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .white
        return searchBar
    }()
    
    private let indirimLabel: UILabel = {
        let label = UILabel()
        label.text = "İndirimler"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    var imageArray = [UIImage]()
    
    
    
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                    collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
        return HomeVC.createSectionLayout(section: sectionIndex)
    })
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(appIcon)
        navigationBarView.addSubview(appTittle)
        navigationBarView.addSubview(adressPin)
        navigationBarView.addSubview(adressLabel)
        
        view.addSubview(searcBar)
        searcBar.delegate = self
        
        view.addSubview(indirimLabel)
        
        navigationController?.navigationBar.backgroundColor = .clear
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
      
        
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
    func configureConstraints() {
        let width = view.frame.width
        let height = view.frame.height
        
        navigationBarView.frame = CGRect(x: 0, y: 0, width: width, height: height/8)
        let navigationHeight = navigationBarView.frame.height
        appIcon.frame = CGRect(x: width/20, y: navigationHeight/2, width: width/10, height: width/10)
        appTittle.frame = CGRect(x: width/20 + width/10 + width/40, y: navigationHeight/2 + width/80, width: width/2, height: height/20)
        adressPin.frame = CGRect(x: width-width/10-width/20, y: navigationHeight/2, width: width/10, height: width/10)
        adressLabel.frame = CGRect(x: width-width/10-width/20-width/4-width/40, y: navigationHeight/2-navigationHeight/20, width: width/4, height: navigationHeight/2)
        
        searcBar.frame = CGRect(x: width/20, y: height/8+width/20, width: width-width/10, height: width/8)
        
        indirimLabel.frame = CGRect(x: width/20, y: height/8+width/8+width/20, width: width/3, height: height/20)
        
        
        
        collectionView.frame = CGRect(x: width/20, y: height/8+width/8+width/20+height/20, width: width-width/10, height: height/2)
        
        
        
    }
    
    private func configureCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        
        
    }
    
    
    
  
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        switch section {
            
        case 0:
            // ITEM
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
            
            
            // VERTICAL GROUP IN HORIZONTAL GROUP
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(120)), repeatingSubitem: item, count: 1)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(360)), repeatingSubitem: verticalGroup, count: 3)
            
            // SECTION
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case 1:
            // ITEM
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
            
            
            // VERTICAL GROUP IN HORIZONTAL GROUP
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(120)), repeatingSubitem: item, count: 1)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(360)), repeatingSubitem: verticalGroup, count: 3)
            
            // SECTION
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
            
            
            
        default:
            // ITEM
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
            
            
            // VERTICAL GROUP IN HORIZONTAL GROUP
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), repeatingSubitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
    }
    
    
    
    
}


extension HomeVC: UISearchBarDelegate {
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .green
        } else if indexPath.section == 1 {
            cell.backgroundColor = .blue
        }
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
}




