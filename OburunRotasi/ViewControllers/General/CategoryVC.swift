//
//  CategoryVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 21.10.2023.
//

import UIKit
import FittedSheets

class CategoryVC: UIViewController {
    
    var kategoriYemekler:  [TumYemekler]?
    var titleCategory: String?
    
    init(kategoriYemekler: [TumYemekler]?, titleCategory: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.kategoriYemekler = kategoriYemekler
        self.titleCategory = titleCategory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(YemekTableViewCell.self, forCellReuseIdentifier: YemekTableViewCell.identifier)
        return tableView
    }()
    
    
    private var viewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        title = self.titleCategory
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    

}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategoriYemekler?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YemekTableViewCell.identifier, for: indexPath) as? YemekTableViewCell else {
            return UITableViewCell()
        }
        
        guard let model = kategoriYemekler?[indexPath.row] else {
            return UITableViewCell()
        }
                cell.model = model
                cell.apply()
        
        viewModel.checkFavoriteStatus(for: model) { isFavorite in
                    DispatchQueue.main.async {
                        cell.imageHeartView.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
                    }
                }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = viewModel.yemeklerListesi[indexPath.row]
        
        
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(model.yemek_resim_adi)")
                let vc = FoodDetailsVC()
                vc.imageView.sd_setImage(with: url)
                vc.nameLabel.text = model.yemek_adi
                if let fiyat = model.yemek_fiyat {
                    vc.priceLabel.text = "\(fiyat) ₺"
                }
                vc.model = model
                let sheetController = SheetViewController(controller: vc, sizes: [.intrinsic])
                self.present(sheetController, animated: true)
    }
    
    
    
    
}
