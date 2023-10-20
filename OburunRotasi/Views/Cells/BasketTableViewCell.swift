//
//  BasketTableViewCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 20.10.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    static let identifier = "BasketTableViewCell"
    
    
    var model : SepetYemek?
    
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
    
    public let yemekFiyatLabel : UILabel = {
        let label = UILabel()
        label.text = "15 ₺"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    public let yemekAdetLabel : UILabel = {
        let label = UILabel()
        label.text = "15 ₺"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    public let deleteBasket: UIButton = {
        let button = UIButton()
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        button.addSubview(imageView)
        button.tintColor = UIColor(hex: "#248CB3")
        return button
    }()
    
    public let yemekToplamFiyatLabel : UILabel = {
        let label = UILabel()
        label.text = "15 ₺"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(hex: "#0C1B3A")
        
        contentView.addSubview(cellView)
        cellView.addSubview(yemekResim)
        cellView.addSubview(yemekIsimLabel)
        cellView.addSubview(yemekFiyatLabel)
        cellView.addSubview(yemekAdetLabel)
        cellView.addSubview(deleteBasket)
        cellView.addSubview(yemekToplamFiyatLabel)
        
        deleteBasket.addTarget(self, action: #selector(deleteBasketClicked), for: .touchUpInside)
        
        
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
        yemekFiyatLabel.frame = CGRect(x: width/10+width/4, y: (height-height/16-width/20)/2, width: width/6, height: height/8)
        yemekAdetLabel.frame = CGRect(x: width/10+width/4, y: (height-height/16-width/20)/2+height/8+width/20, width: width/6, height: height/8)
        
        deleteBasket.frame = CGRect(x: width-width/10-width/8, y:  (height-height/1.44-width/20)/2, width: width/8, height: width/8)
        
        
        yemekToplamFiyatLabel.frame = CGRect(x: (width-width/2)-width/10-width/20, y: (height-height/1.44-width/20)/2+height/1.44-height/5, width: width/2, height: width/10)
    }
    
    func configureFiyat() {
        
        
        guard let toplamFiyat = Int(model!.yemek_fiyat) else {
            return
        }
        
        guard let siparisAdetInt = Int(model!.yemek_siparis_adet) else {
            return
        }
        
        
        
        yemekFiyatLabel.text = "\(toplamFiyat/siparisAdetInt) ₺"
        
    }
    
    @objc func deleteBasketClicked() {
        
        guard let id = Int(model!.sepet_yemek_id) else {
            return
        }
        
        APICaller.shared.sepettekiYekeleriSil(sepet_yemek_id: id, kullanici_adi: "hakanbaran")
//        print(id)
    }

}
