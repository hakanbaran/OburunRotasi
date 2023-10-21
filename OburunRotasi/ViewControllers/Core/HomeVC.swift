//
//  ViewController.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit
import SDWebImage
import FittedSheets

class HomeVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(YemekTableViewCell.self, forCellReuseIdentifier: YemekTableViewCell.identifier)
        return tableView
    }()
    
    private var headerView: HeroHeaderUIView?
    
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.delegate = self
        tableView.dataSource = self
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.frame.width/1.1))
        headerView?.delegate = self
        tableView.tableHeaderView = headerView
        headerView?.searcBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func bindViewModel() {
            viewModel.downloadTumYemekler { [weak self] result in
                guard let self = self else { return }
                if case .failure(let error) = result {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfYemekler
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YemekTableViewCell.identifier, for: indexPath) as? YemekTableViewCell else {
            return UITableViewCell()
        }
        let model = viewModel.yemek(at: indexPath.row)
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
        let model = viewModel.yemek(at: indexPath.row)
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


extension HomeVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc  = SearchVC() 

        self.present(vc, animated: true, completion: nil)
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
extension HomeVC: HeroHeaderDelegate {
    func didSelectCategory(_ category: String) {
        
        if category == "Türk Mutfağı" {
            let filteredYemekler = viewModel.yemeklerListesi.filter { $0.yemek_id == "1" || $0.yemek_id == "2" || $0.yemek_id == "6" || $0.yemek_id == "13"}
            let vc = CategoryVC(kategoriYemekler: filteredYemekler, titleCategory: category)
            navigationController?.pushViewController(vc, animated: true)
        } else if category == "Tatlılar" {
            let filteredYemekler = viewModel.yemeklerListesi.filter { $0.yemek_id == "2" || $0.yemek_id == "6" || $0.yemek_id == "13" || $0.yemek_id == "14" }
            let vc = CategoryVC(kategoriYemekler: filteredYemekler, titleCategory: category)
            navigationController?.pushViewController(vc, animated: true)
        } else if category == "İçecekler" {
            let filteredYemekler = viewModel.yemeklerListesi.filter { $0.yemek_id == "1" || $0.yemek_id == "3" || $0.yemek_id == "7" || $0.yemek_id == "12" || $0.yemek_id == "13" }
            let vc = CategoryVC(kategoriYemekler: filteredYemekler, titleCategory: category)
            navigationController?.pushViewController(vc, animated: true)
        } else if category == "Dünyadan" {
            let filteredYemekler = viewModel.yemeklerListesi.filter { $0.yemek_id == "4" || $0.yemek_id == "5" || $0.yemek_id == "7" || $0.yemek_id == "9" || $0.yemek_id == "10" || $0.yemek_id == "11" || $0.yemek_id == "14" }
            let vc = CategoryVC(kategoriYemekler: filteredYemekler, titleCategory: category)
            navigationController?.pushViewController(vc, animated: true)
        } else if category == "Tavuk/Balık" {
            let filteredYemekler = viewModel.yemeklerListesi.filter { $0.yemek_id == "4" || $0.yemek_id == "5" }
            let vc = CategoryVC(kategoriYemekler: filteredYemekler, titleCategory: category)
            navigationController?.pushViewController(vc, animated: true)
        } else if category == "Köfte" {
            let filteredYemekler = viewModel.yemeklerListesi.filter { $0.yemek_id == "8" || $0.yemek_id == "12" || $0.yemek_id == "6" }
            let vc = CategoryVC(kategoriYemekler: filteredYemekler, titleCategory: category)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
