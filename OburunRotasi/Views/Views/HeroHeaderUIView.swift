//
//  HeroHeaderUIView.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 16.10.2023.
//

import UIKit

enum BrowseSectionType {
    case indirim // 1
    case kategori // 2
    
    var title: String {
        switch self {
        case .indirim:
            return "İndirimler"
        case .kategori:
            return "Kategoriler"
        }
    }
}

class HeroHeaderUIView: UIView {
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#0C1B3A")
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 2
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
        return HeroHeaderUIView.createSectionLayout(section: sectionIndex)
    })
    
    private var sections = [BrowseSectionType]()
    
    private let yemeklerLabel: UILabel = {
        let label = UILabel()
        label.text = "Tüm Yemekler"
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(navigationBarView)
        backgroundColor = UIColor(hex: "#0C1B3A")
        navigationBarView.addSubview(appIcon)
        navigationBarView.addSubview(appTittle)
        navigationBarView.addSubview(adressPin)
        navigationBarView.addSubview(adressLabel)
        navigationBarView.addSubview(yemeklerLabel)
        
        addSubview(searcBar)
        searcBar.delegate = self
        
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        imageArray.append(UIImage(named: "fastFood")!)
        
        configureCollectionView()
        
        getData()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        navigationBarView.frame = CGRect(x: 0, y: 0, width: width, height: height/8)
        configureConstraints()
    }
    
    func configureConstraints() {
        
        
        let navigationHeight = navigationBarView.frame.height
        appIcon.frame = CGRect(x: width/20, y: -width/20, width: width/10, height: width/10)
        appTittle.frame = CGRect(x: width/20 + width/10 + width/40, y: -width/20+navigationHeight/10 + width/80, width: width/2, height: height/20)
        adressPin.frame = CGRect(x: width-width/10-width/20, y: -width/20, width: width/10, height: width/10)
        adressLabel.frame = CGRect(x: width-width/10-width/20-width/4-width/40, y: -width/20-navigationHeight/20, width: width/4, height: navigationHeight)

        searcBar.frame = CGRect(x: width/20, y: width/10, width: width-width/10, height: width/8)
        
        collectionView.frame = CGRect(x: width/20, y: width/4, width: width-width/10, height: width/1.75)
        
        yemeklerLabel.frame = CGRect(x: width/15, y: width/4+collectionView.frame.height+width/30, width: width/2, height: height/20)
        
        
        
    }
    
    private func configureCollectionView() {
        addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(IndirimCollectionCell.self, forCellWithReuseIdentifier: IndirimCollectionCell.identifier)
        collectionView.register(KategoriCollectionCell.self, forCellWithReuseIdentifier: KategoriCollectionCell.identifier)
        collectionView.register(FoodHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FoodHeaderCollectionReusableView.identifier)
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

extension HeroHeaderUIView: UISearchBarDelegate {
    
}


extension HeroHeaderUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
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
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FoodHeaderCollectionReusableView.identifier, for: indexPath) as? FoodHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            scrollView.contentOffset.y = 0
        }
}

