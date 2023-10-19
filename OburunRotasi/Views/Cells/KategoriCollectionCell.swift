//
//  KategoriCollectionCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 14.10.2023.
//

import UIKit
import SDWebImage

class KategoriCollectionCell: UICollectionViewCell {
    
    static let identifier = "KategoriCollectionCell"
    
    private let backgroudView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#248CB3")
        view.layer.cornerRadius = 7
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")
        imageView.alpha = 0.8
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "İçecekler"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroudView)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        imageView.frame = contentView.bounds
        
        imageView.image = UIImage(named: "baklava")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroudView.frame = CGRect(x: 0, y: height/4, width: width, height: height/1.4)
        imageView.frame = CGRect(x: (width-width/1.4)/2, y: -height/4, width: width/1.4, height: width/1.4)
        label.frame = CGRect(x: width/2-width/2, y: height/2, width: width, height: height/2)
    }
    
    
    
}
