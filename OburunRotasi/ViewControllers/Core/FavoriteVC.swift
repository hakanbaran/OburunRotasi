//
//  FavoriteVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 12.10.2023.
//

import UIKit
import SDWebImage
import CoreData
import FittedSheets

class FavoriteVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(YemekTableViewCell.self, forCellReuseIdentifier: YemekTableViewCell.identifier)
        return tableView
    }()
    
    var favoriYemekler = [YemeklerData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favori Yemeklerim"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchingFood()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func fetchingFood() {
        DataPersistantManager.shared.fetchingFavorite { result in
            switch result {
            case .success(let yemeklerDatas):
                self.favoriYemekler = yemeklerDatas
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YemekTableViewCell.identifier, for: indexPath) as? YemekTableViewCell else {
            return UITableViewCell()
        }
        let model = favoriYemekler[indexPath.row]
        
        
        
        let resimAdi = model.yemek_resim_adi ?? ""
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)")
        cell.yemekResim.sd_setImage(with: url)
        cell.yemekIsimLabel.text = model.yemek_adi
        if let fiyat = model.yemek_fiyat {
            cell.yemekFiyatLabel.text = "\(fiyat) ₺"
        }
        
        let id = model.yemek_id
        cell.model?.yemek_id = id
        let request: NSFetchRequest<YemeklerData>
        request = YemeklerData.fetchRequest()
        request.predicate = NSPredicate(format: "yemek_id == %@", id!)
        do {
            let existing = try context.fetch(request)
            if existing.isEmpty {
                cell.imageHeartView.image = UIImage(systemName: "heart")
            } else {
                cell.imageHeartView.image = UIImage(systemName: "heart.fill")
            }
        } catch {
            print("HATAA!!!!")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistantManager.shared.deleteFavorite(model: self.favoriYemekler[indexPath.row])
            self.favoriYemekler.remove(at: indexPath.row)
            tableView.reloadData()
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = favoriYemekler[indexPath.row]
        
        guard let resimName = model.yemek_resim_adi else {
            return
        }
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimName)")
        let vc = FoodDetailsVC()
        vc.imageView.sd_setImage(with: url)
        vc.nameLabel.text = model.yemek_adi
        if let fiyat = model.yemek_fiyat {
            vc.priceLabel.text = "\(fiyat) ₺"
        }
        vc.model2 = model
        let sheetController = SheetViewController(controller: vc, sizes: [.intrinsic])
        self.present(sheetController, animated: true)
    }
}
