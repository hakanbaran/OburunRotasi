//
//  ProfileCell.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 20.10.2023.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    
    static let identifier = "ProfileCell"
    
    private let profileCellView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: "#162544")
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "HAKAN BARAN"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let iconImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = .lightGray
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        contentView.addSubview(profileCellView)
        contentView.backgroundColor = UIColor(hex: "#0C1B3A")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        profileCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        profileCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        profileCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 2).isActive = true
        
        profileCellView.addSubview(nameLabel)
        profileCellView.addSubview(iconImage)
        
        nameLabel.centerYAnchor.constraint(equalTo: profileCellView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileCellView.leadingAnchor, constant: 20).isActive = true
        
        iconImage.centerYAnchor.constraint(equalTo: profileCellView.centerYAnchor).isActive = true
        iconImage.trailingAnchor.constraint(equalTo: profileCellView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    
    

}
