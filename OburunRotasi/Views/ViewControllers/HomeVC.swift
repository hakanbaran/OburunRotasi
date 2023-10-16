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
    
    var title: String {
        switch self {
        case .indirim:
            return "İndirimdeki Ürünler"
        case .kategori:
            return "Kategoriler"
        }
    }
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
    
    var imageArray = [UIImage]()
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                    collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
        return HomeVC.createSectionLayout(section: sectionIndex)
    })
    
    private var sections = [BrowseSectionType]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(HomeFoodCell.self, forCellReuseIdentifier: HomeFoodCell.identifier)
        
        return tableView
    }()
    
    
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
        
        navigationController?.navigationBar.backgroundColor = .clear
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        
        configureCollectionView()
        
        getData()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        collectionView.frame = CGRect(x: width/20, y: height/8+width/8+width/20+height/20, width: width-width/10, height: width/1.75)
        
        
        
//        tableView.frame = CGRect(x: width/20, y: height/8+width/8+width/10+height/20+width/1.75, width: width-width/10, height: 300)
        
        configureTableViewConstraints()
        
    }
    
    func configureTableViewConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        let width = view.frame.width
        let height = view.frame.height
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: width/20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: width/20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -width/20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: width/20)
        ]
        
        
        NSLayoutConstraint.activate(tableViewConstraints)
        
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(IndirimCollectionCell.self, forCellWithReuseIdentifier: IndirimCollectionCell.identifier)
        collectionView.register(KategoriCollectionCell.self, forCellWithReuseIdentifier: KategoriCollectionCell.identifier)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    func getData() {
        sections.append(.indirim)
        sections.append(.kategori)
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.08)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        switch section {
        case 0:
            // ITEM
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
            // VERTICAL GROUP IN HORIZONTAL GROUP
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120)), repeatingSubitem: item, count: 1)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), repeatingSubitem: verticalGroup, count: 2)
            // SECTION
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
            return section
            
        case 1:
            // ITEM
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
            // VERTICAL GROUP IN HORIZONTAL GROUP
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(60)), repeatingSubitem: item, count: 1)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), repeatingSubitem: verticalGroup, count: 4)
            // SECTION
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryViews
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
        
        let type = sections[section]
        
        switch type {
            
        case .indirim:
            return imageArray.count
        case .kategori:
            
            return imageArray.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = sections[indexPath.section]
        
        switch type {
            
        case .indirim:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndirimCollectionCell.identifier, for: indexPath) as? IndirimCollectionCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = imageArray[indexPath.row]
            return cell
            
        case .kategori:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KategoriCollectionCell.identifier, for: indexPath) as? KategoriCollectionCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = imageArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            scrollView.contentOffset.y = 0
//        }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width/2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeFoodCell.identifier, for: indexPath) as? HomeFoodCell else {
            return UITableViewCell()
        }
        
        APICaller.shared.tumYemekler { result in
            switch result {
                
            case .success(let yemekler):
                let model = yemekler[indexPath.row]
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(model.yemek_resim_adi)")
                
                cell.foodImage.sd_setImage(with: url)
                
            case .failure(let error):
                
                print(error.localizedDescription)
                
            }
        }
        
//        let cell = UITableViewCell()
        
        return cell
    }
    
    
}



