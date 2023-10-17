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
        tableView.separatorStyle = .none
        tableView.register(HomeVCTableViewCell.self, forCellReuseIdentifier: HomeVCTableViewCell.identifier)
        return tableView
    }()
    
    private var headerView: HeroHeaderUIView?
    var yemeklerListesi = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.delegate = self
        tableView.dataSource = self
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.frame.width/1.1))
        tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tumYemekler()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tumYemekler() {
        
        APICaller.shared.tumYemekler { result in
            switch result {
            case .success(let yemeklerListesi):
                self.yemeklerListesi = yemeklerListesi
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeVCTableViewCell.identifier, for: indexPath) as? HomeVCTableViewCell else {
            return UITableViewCell()
        }
        let model = yemeklerListesi[indexPath.row]
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(model.yemek_resim_adi)")
        cell.yemekResim.sd_setImage(with: url)
        cell.yemekIsimLabel.text = model.yemek_adi
        
        if let fiyat = model.yemek_fiyat {
            cell.yemekFiyatLabel.text = "\(fiyat) ₺"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        let maxOffset: CGFloat = 100.0
        
        let alpha = min(1, max(1 - offset / maxOffset, 0))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.alpha = alpha
    }
}



