//
//  HomeFoodCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 13.10.2023.
//

import UIKit

class HomeFoodCell: UITableViewCell {

    static let identifier = "HomeFoodCell"
    
    let cellView : UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    public let foodImage : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person"))
        image.backgroundColor = UIColor(hex: "#248CB3")
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
        
        contentView.backgroundColor = UIColor(hex: "#162544")
        contentView.addSubview(cellView)
        
        cellView.addSubview(foodImage)
        cellView.addSubview(foodNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.frame.width
        let height = contentView.frame.height
        
        cellView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: width/10, bottom: 10, right: width/10))
        foodImage.frame = CGRect(x: width/20, y: 0, width: width/4, height: height)
        foodNameLabel.frame = CGRect(x: width / 2, y: height / 2, width: width / 2, height: height / 2)
    }
}


