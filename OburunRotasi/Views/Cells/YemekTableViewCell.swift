//
//  HomeFoodCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 13.10.2023.
//

import UIKit
import SDWebImage
import FittedSheets



class YemekTableViewCell: UITableViewCell {
    
    static let identifier = "YemekTableViewCell"
    
    
    let categories: [Category] = [
        Category(id: "1", name1: "Türk Mutfağı", name2: "İçecekler", name3: "Köfte"),
        Category(id: "2", name1: "Türk Mutfağı", name2: "Tatlılar", name3: ""),
        Category(id: "3", name1: "İçecekler", name2: "", name3: ""),
        Category(id: "4", name1: "Dünyadan", name2: "Tavuk/Balık", name3: ""),
        Category(id: "5", name1: "Dünyadan", name2: "Tavuk/Balık", name3: ""),
        Category(id: "6", name1: "Türk Mutfağı", name2: "Tatlılar", name3: "Köfte"),
        Category(id: "7", name1: "İçecekler", name2: "Dünyadan", name3: ""),
        Category(id: "8", name1: "Türk Mutfağı", name2: "Köfte", name3: ""),
        Category(id: "9", name1: "Dünyadan", name2: "", name3: ""),
        Category(id: "10", name1: "Dünyadan", name2: "", name3: ""),
        Category(id: "11", name1: "Dünyadan", name2: "", name3: ""),
        Category(id: "12", name1: "İçecekler", name2: "Köfte", name3: ""),
        Category(id: "13", name1: "Türk Mutfağı", name2: "Tatlılar", name3: ""),
        Category(id: "14", name1: "Tatlılar", name2: "Dünyadan", name3: ""),
    ]
    var model : TumYemekler?
    
    var favoriYemekler = [YemeklerData]()
    
    let imageHeartView = UIImageView()
    
    let cellView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#162544")
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0.2
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    public let yemekResim : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person"))
        image.backgroundColor = UIColor(hex: "#248CB3")
        image.layer.cornerRadius = 10
        image.layer.borderWidth = 0.2
        image.alpha = 0.75
        return image
    }()
    
    public let yemekIsimLabel : UILabel = {
        let label = UILabel()
        label.text = "Pizza"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    public let yemekKategori1: UIButton = {
        let button = UIButton()
        button.setTitle("Türk Mutfağı", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#248CB3")
        return button
    }()
    
    public let yemekKategori2: UIButton = {
        let button = UIButton()
        button.setTitle("Türk Mutfağı", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#248CB3")
        return button
    }()
    
    public let yemekKategori3: UIButton = {
        let button = UIButton()
        button.setTitle("Türk Mutfağı", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#248CB3")
        return button
    }()
    
    public let yemekFiyatLabel : UILabel = {
        let label = UILabel()
        label.text = "15 ₺"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    
    public let favoriButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(hex: "#248CB3")
        return button
    }()
    
    public let ucretsiz: UIButton = {
        let button = UIButton()
        button.setTitle("Ücretsiz Gönderim", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(hex: "#248CB3")
        
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
   
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(hex: "#0C1B3A")
        contentView.addSubview(cellView)
        
        cellView.addSubview(yemekResim)
        cellView.addSubview(yemekIsimLabel)
        cellView.addSubview(yemekKategori1)
        cellView.addSubview(yemekKategori2)
        cellView.addSubview(yemekKategori3)
        cellView.addSubview(yemekFiyatLabel)
        cellView.addSubview(favoriButton)
        cellView.addSubview(ucretsiz)
        
        favoriButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        imageHeartView.contentMode = .scaleAspectFit
        imageHeartView.image = UIImage(systemName: "heart")
        imageHeartView.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        favoriButton.addSubview(imageHeartView)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.frame.width
        let height = contentView.frame.height
        
        cellView.frame = contentView.frame.inset(by: UIEdgeInsets(top: width/40, left: width/20, bottom: width/40, right: width/20))
        yemekResim.frame = CGRect(x: width/20, y: (height-height/1.44-width/20)/2, width: width/4, height: height/1.44)
        yemekIsimLabel.frame = CGRect(x: width/10+width/4, y: (height-height/1.44-width/20)/2, width: width/3, height: height/4)
        yemekKategori1.frame = CGRect(x: width/20+width/4+width/40, y: (height-height/1.44-width/20)/2+height/4, width: width/6, height: height/8)
        yemekKategori2.frame = CGRect(x: width/20+width/4+width/6+width/50+width/40, y: (height-height/1.44-width/20)/2+height/4, width: width/6, height: height/8)
        yemekKategori3.frame = CGRect(x: width/20+width/4+width/6+width/50+width/6+width/50+width/40, y: (height-height/1.44-width/20)/2+height/4, width: width/6, height: height/8)
        yemekFiyatLabel.frame = CGRect(x: width/10+width/4, y: (height-height/1.44-width/20)/2+height/1.44-height/8, width: width/6, height: height/8)
        favoriButton.frame = CGRect(x: width-width/10-width/8, y:  (height-height/1.44-width/20)/2, width: width/8, height: width/8)
        ucretsiz.frame = CGRect(x: width-width/10-width/8-width/5.3, y: (height-height/1.44-width/20)/2+height/1.44-height/7, width: width/3.5, height: width/20)
        ucretsiz.layer.cornerRadius = ucretsiz.frame.height/2
    }
    
    @objc func favoriteButtonClicked() {
        
        guard let model = model  else {
            return
        }
        guard let id = model.yemek_id else {
            return
        }
        DataPersistantManager.shared.filterFavorite(id: id) { result in
            switch result {
            case .success(let filterFood):
                if filterFood.isEmpty {
                    self.imageHeartView.image = UIImage(systemName: "heart.fill")
                    DataPersistantManager.shared.addFavorite(model: model) { result in
                        switch result {
                        case .success(let yemek):
                            print(yemek)
                        case.failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    

    
    func setCategoryLabels(for categoryId: String?) {
        guard let id = categoryId, let category = categories.first(where: { $0.id == id }) else {
            return
        }
        yemekKategori1.setTitle(category.name1, for: .normal)
        yemekKategori2.setTitle(category.name2, for: .normal)
        yemekKategori3.setTitle(category.name3, for: .normal)
        yemekKategori2.isHidden = category.name2!.isEmpty
        yemekKategori3.isHidden = category.name3.isEmpty
    }
    
    
    func apply() {
        
        setCategoryLabels(for: model?.yemek_id)
        
        if let resim = model?.yemek_resim_adi {
            let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resim)")
            yemekResim.sd_setImage(with: url)
        }
        yemekIsimLabel.text = model?.yemek_adi
        if let fiyat = model?.yemek_fiyat {
            yemekFiyatLabel.text = "\(fiyat) ₺"
        }
    }
}


