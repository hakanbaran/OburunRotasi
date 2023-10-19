//
//  HomeFoodCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 13.10.2023.
//

import UIKit

class HomeVCTableViewCell: UITableViewCell {

    static let identifier = "HomeVCTableViewCell"
    
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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        button.addSubview(imageView)
        button.tintColor = UIColor(hex: "#248CB3")
        return button
    }()
    
    public let sepetButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        button.addSubview(imageView)
        button.tintColor = UIColor(hex: "#248CB3")
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
        cellView.addSubview(sepetButton)
        
        favoriButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
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
        sepetButton.frame = CGRect(x: width-width/10-width/8, y: (height-height/1.44-width/20)/2+height/1.44-height/5, width: width/10, height: width/10)
    }
    
    @objc func favoriteButtonClicked() {
        
        let yemekModel1 = Yemekler(yemek_id: "15", yemek_adi: "Künefe", yemek_resim_adi: "biyerler.png", yemek_fiyat: "24")
        
        DataPersistantManager.shared.addFavorite(model: yemekModel1) { result in
            switch result {
                
            case .success(let yemek):
                print(yemek)
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        
        
    }
}


