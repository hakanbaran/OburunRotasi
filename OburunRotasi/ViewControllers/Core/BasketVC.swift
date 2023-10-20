//
//  BasketVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 19.10.2023.
//

import UIKit
import SDWebImage

class BasketVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifier)
        return tableView
    }()
    
    private let toplamFiyatLabel: UILabel = {
        let label = UILabel()
        
        label.text = "187 ₺"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        
        return label
    }()
    
    var sepetYemekler = [SepetYemek]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(toplamFiyatLabel)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APICaller.shared.sepettekiYemekleriCek(kullaniciAdi: "hakanbaran") { result in
            switch result {
            case .success(let yemekler):
                self.sepetYemekler = yemekler
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let height = view.frame.height
        
        tableView.frame = CGRect(x: 0, y: 0, width: width, height: height-height/5)
    }
    

}

extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()
        }
        let model = sepetYemekler[indexPath.row]
        
        let resimAdi = model.yemek_resim_adi
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)")
        cell.yemekResim.sd_setImage(with: url)
        cell.yemekIsimLabel.text = model.yemek_adi
        
        cell.yemekAdetLabel.text = "Adet: \(model.yemek_siparis_adet)"
        
        cell.model = model
        cell.configureFiyat()
        
        cell.yemekIsimLabel.text = model.yemek_adi
        
        cell.yemekToplamFiyatLabel.text = "Toplam: \(model.yemek_fiyat) ₺"
        
        
        
        return cell
    }
    
    
}
