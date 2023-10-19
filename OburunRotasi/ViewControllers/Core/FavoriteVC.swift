//
//  FavoriteVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 12.10.2023.
//

import UIKit

class FavoriteVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(HomeVCTableViewCell.self, forCellReuseIdentifier: HomeVCTableViewCell.identifier)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favori Yemeklerim"
    }
    
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeVCTableViewCell.identifier, for: indexPath) as? HomeVCTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    
}
