//
//  HomeFoodCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 13.10.2023.
//

import UIKit

class HomeFoodCell: UITableViewCell {

    static let identifier = "HomeFoodCell"
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(hex: "#0C1B3A")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.frame.width
        let height = contentView.frame.height
    }
    
}
