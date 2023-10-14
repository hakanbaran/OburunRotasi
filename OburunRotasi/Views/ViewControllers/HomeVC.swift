//
//  ViewController.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(HomeFoodCell.self, forCellReuseIdentifier: HomeFoodCell.identifier)
        return tableView
        
    }()
    
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
    
    private let indirimCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .clear
        collection.register(IndirimCollectionCell.self, forCellWithReuseIdentifier: IndirimCollectionCell.identifier)
        return collection
    }()
    var imageArray = [UIImage]()
    
    private let kategoriLabel: UILabel = {
        let label = UILabel()
        label.text = "Kategoriler"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let kategoriCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .clear
        collection.register(IndirimCollectionCell.self, forCellWithReuseIdentifier: IndirimCollectionCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        view.addSubview(tableView)
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(appIcon)
        navigationBarView.addSubview(appTittle)
        navigationBarView.addSubview(adressPin)
        navigationBarView.addSubview(adressLabel)
        
        view.addSubview(searcBar)
        searcBar.delegate = self
        
        view.addSubview(indirimLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.backgroundColor = .clear
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        view.addSubview(indirimCollection)
        
        indirimCollection.delegate = self
        indirimCollection.dataSource = self
        
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        
        view.addSubview(kategoriLabel)
        
        view.addSubview(kategoriCollection)
        kategoriCollection.delegate = self
        kategoriCollection.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
    func configureConstraints() {
        let width = view.frame.width
        let height = view.frame.height
        
        tableView.frame = view.bounds
        
        navigationBarView.frame = CGRect(x: 0, y: 0, width: width, height: height/8)
        let navigationHeight = navigationBarView.frame.height
        appIcon.frame = CGRect(x: width/20, y: navigationHeight/2, width: width/10, height: width/10)
        appTittle.frame = CGRect(x: width/20 + width/10 + width/40, y: navigationHeight/2 + width/80, width: width/2, height: height/20)
        adressPin.frame = CGRect(x: width-width/10-width/20, y: navigationHeight/2, width: width/10, height: width/10)
        adressLabel.frame = CGRect(x: width-width/10-width/20-width/4-width/40, y: navigationHeight/2-navigationHeight/20, width: width/4, height: navigationHeight/2)
        
        searcBar.frame = CGRect(x: width/20, y: height/8+width/20, width: width-width/10, height: width/8)
        
        indirimLabel.frame = CGRect(x: width/20, y: height/8+width/8+width/20, width: width/3, height: height/20)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = width/20
        layout.itemSize = CGSize(width: width/2, height: width/3)
        indirimCollection.collectionViewLayout = layout
        indirimCollection.frame = CGRect(x: width/20, y: height/8+width/8+width/20+height/20, width: width-width/10, height: width/3.56)
        
        kategoriLabel.frame = CGRect(x: width/20, y: height/8+width/8+width/20+height/20+width/3.56, width: width/3, height: height/20)
        
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeFoodCell.identifier, for: indexPath)
        
        return cell
    }
    
    
}

extension HomeVC: UISearchBarDelegate {
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = indirimCollection.dequeueReusableCell(withReuseIdentifier: IndirimCollectionCell.identifier, for: indexPath) as? IndirimCollectionCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = imageArray[indexPath.item]
        return cell
    }
}


