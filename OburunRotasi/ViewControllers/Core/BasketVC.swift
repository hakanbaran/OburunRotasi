//
//  BasketVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 19.10.2023.
//

import UIKit

class BasketVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(YemekTableViewCell.self, forCellReuseIdentifier: YemekTableViewCell.identifier)
        return tableView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
