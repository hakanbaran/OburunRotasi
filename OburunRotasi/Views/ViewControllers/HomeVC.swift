//
//  ViewController.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(HomeFoodCell.self, forCellReuseIdentifier: HomeFoodCell.identifier)
        
        return tableView
    }()
    
    private var headerView: HeroHeaderUIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.frame.width/1.18))
        print(view.frame.width)
        tableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width/2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeFoodCell.identifier, for: indexPath) as? HomeFoodCell else {
            return UITableViewCell()
        }
        
        APICaller.shared.tumYemekler { result in
            switch result {
                
            case .success(let yemekler):
                let model = yemekler[indexPath.row]
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(model.yemek_resim_adi)")
                
                cell.foodImage.sd_setImage(with: url)
                
            case .failure(let error):
                
                print(error.localizedDescription)
                
            }
        }
        
//        let cell = UITableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tüm Yiyecekler"
        headerView.addSubview(label)
        // Yazı boyutunu ve kalınlığını özelleştirin
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        return headerView
    }
    
   
    
    
}



