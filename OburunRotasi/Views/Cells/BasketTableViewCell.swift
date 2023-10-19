//
//  BasketTableViewCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 20.10.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    static let identifier = "BasketTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(hex: "#0C1B3A")
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
