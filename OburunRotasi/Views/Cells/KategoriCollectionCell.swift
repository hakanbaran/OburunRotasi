//
//  KategoriCollectionCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 14.10.2023.
//

import UIKit

class KategoriCollectionCell: UICollectionViewCell {
    
    static let identifier = "KategoriCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "İçecekler"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
