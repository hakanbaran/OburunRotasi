//
//  IndirimCollectionCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 14.10.2023.
//

import UIKit

class IndirimCollectionCell: UICollectionViewCell {
    
    static let identifier = "IndirimCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(imageView)
            imageView.frame = contentView.bounds
            
            
            
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
