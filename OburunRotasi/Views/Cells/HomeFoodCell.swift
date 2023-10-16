//
//  HomeFoodCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 13.10.2023.
//

import UIKit

class HomeFoodCell: UITableViewCell {

    static let identifier = "HomeFoodCell"
    
    public let foodImage : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person"))
        image.tintColor = .yellow
        return image
    }()
    
    public let foodNameLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Pizza"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(hex: "#0C1B3A")
        
        
        contentView.addSubview(foodImage)
        contentView.addSubview(foodNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.width
        let height = contentView.frame.height
        
        foodImage.frame = CGRect(x: width/20, y: width/20, width: width/4, height: width/4)
        foodNameLabel.frame = CGRect(x: width / 2, y: height / 2, width: width / 2, height: height / 2)

        
    }
    
    
    
}


