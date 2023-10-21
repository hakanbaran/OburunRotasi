//
//  SearchVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 21.10.2023.
//

import UIKit
import FittedSheets

class SearchVC: UIViewController {
    
    let searcBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Yemek Arama..."
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .white
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(YemekTableViewCell.self, forCellReuseIdentifier: YemekTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Yemek Bulunamadı..."
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    
    
    private var viewModel = SearcheViewModel()
    
    var searchResults: [TumYemekler] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        view.addSubview(searcBar)
        view.addSubview(tableView)
        view.addSubview(noResultLabel)
        tableView.delegate = self
        tableView.dataSource = self
        searcBar.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let height = view.frame.height
        
        searcBar.frame = CGRect(x: width/20, y: width/10, width: width-width/10, height: width/8)
        tableView.frame = CGRect(x: 0, y: width/10+width/8+width/10, width: width, height: height-width/10+width/8+width/10)
        
        noResultLabel.frame = CGRect(x: 0, y: height/2-height/16, width: width, height: height/8)
        
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
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

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bulunanYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YemekTableViewCell.identifier, for: indexPath) as? YemekTableViewCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.bulunanYemekler[indexPath.row]
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
        
        let model = viewModel.bulunanYemekler[indexPath.row]
        
        
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

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let arananYemek = searchText
        viewModel.bulunanYemekler.removeAll()
            for yemek in viewModel.yemeklerListesi {
                if yemek.yemek_adi!.lowercased().contains(arananYemek.lowercased()) {
                    viewModel.bulunanYemekler.append(yemek)
                }
            }
        if viewModel.bulunanYemekler.isEmpty {
            noResultLabel.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            noResultLabel.isHidden = true
        }
            tableView.reloadData()
        }
}
