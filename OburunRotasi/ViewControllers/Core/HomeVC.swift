//
//  ViewController.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit
import SDWebImage
import FittedSheets


struct Category {
    var id: String?
    var name1 : String?
    var name2 : String?
    var name3 : String
}

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
    
    let categories: [Category] = [
        Category(id: "1", name1: "Türk Mutfağı", name2: "İçecekler", name3: "Köfte"),
        Category(id: "2", name1: "Türk Mutfağı", name2: "Tatlılar", name3: ""),
        Category(id: "3", name1: "İçecekler", name2: "", name3: ""),
        Category(id: "4", name1: "Dünyadan", name2: "Tavuk/Balık", name3: ""),
        Category(id: "5", name1: "Dünyadan", name2: "Tavuk/Balık", name3: ""),
        Category(id: "6", name1: "Türk Mutfağı", name2: "Tatlılar", name3: "Köfte"),
        Category(id: "7", name1: "İçecekler", name2: "Dünyadan", name3: ""),
        Category(id: "8", name1: "Türk Mutfağı", name2: "Köfte", name3: ""),
        Category(id: "9", name1: "Dünyadan", name2: "", name3: ""),
        Category(id: "10", name1: "Dünyadan", name2: "", name3: ""),
        Category(id: "11", name1: "Dünyadan", name2: "", name3: ""),
        Category(id: "12", name1: "İçecekler", name2: "Köfte", name3: ""),
        Category(id: "13", name1: "Türk Mutfağı", name2: "Tatlılar", name3: ""),
        Category(id: "14", name1: "Tatlılar", name2: "Dünyadan", name3: ""),
    ]
    
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
        
        setCategoryLabels(for: model.yemek_id, in: cell)
        return cell
    }
    
    func setCategoryLabels(for categoryId: String?, in cell: HomeVCTableViewCell) {
        guard let id = categoryId, let category = categories.first(where: { $0.id == id }) else {
            return
        }
        cell.yemekKategori1.setTitle(category.name1, for: .normal)
        cell.yemekKategori2.setTitle(category.name2, for: .normal)
        cell.yemekKategori3.setTitle(category.name3, for: .normal)
        cell.yemekKategori2.isHidden = category.name2!.isEmpty
        cell.yemekKategori3.isHidden = category.name3.isEmpty
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = yemeklerListesi[indexPath.row]
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(model.yemek_resim_adi)")
        let vc = FoodDetailsVC()
        vc.imageView.sd_setImage(with: url)
        vc.nameLabel.text = model.yemek_adi
        if let fiyat = model.yemek_fiyat {
            vc.priceLabel.text = "\(fiyat) ₺"
        }
        let sheetController = SheetViewController(controller: vc, sizes: [.intrinsic])
        self.present(sheetController, animated: true)
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



extension String {
    func extractValue(forKey key: String) -> String? {
        if let range = self.range(of: "\(key): ") {
            let startIndex = range.upperBound
            let substring = self[startIndex...]
            if let endIndex = substring.firstIndex(of: ",") {
                return String(substring[..<endIndex])
            }
        }
        return nil
    }
}
