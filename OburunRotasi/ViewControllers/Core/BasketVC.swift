//
//  BasketVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 19.10.2023.
//

import UIKit
import SDWebImage

class BasketVC: UIViewController  {
    
   
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifier)
        return tableView
    }()
    
    private let toplamLabel: UILabel = {
        let label = UILabel()
        label.text = "Toplam: 0 ₺"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        
        return label
    }()
    
   
    
    private let sepetOnayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepeti Onayla", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(hex: "#162544")
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepetinizde Yemek Bulunmuyor."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    var sepetYemekler = [SepetYemek]()
    
    private var viewModel = SepetViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sepetim"
        
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(toplamLabel)
        view.addSubview(sepetOnayButton)
        view.addSubview(noResultLabel)
        
        sepetOnayButton.addTarget(self, action: #selector(sepetOnayButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
        APICaller.shared.sepettekiYemekleriCek(kullaniciAdi: "hakanbaran2") { result in
            switch result {
            case .success(let yemekler):
                self.sepetYemekler = yemekler
                var toplam = 0
                for yemek in self.sepetYemekler {
                    guard let fiyatInt = Int(yemek.yemek_fiyat) else {
                        return
                    }
                    toplam += fiyatInt
                }
                self.tableView.reloadData()
                self.toplamLabel.text = "Toplam: \(toplam) ₺"
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
        toplamLabel.frame = CGRect(x: width/20, y: height-height/5+width/20, width: width, height: width/8)
        sepetOnayButton.frame = CGRect(x: width-width/2.8-width/20, y: height-height/5+width/20, width: width/2.8, height: width/8)
        sepetOnayButton.layer.cornerRadius = sepetOnayButton.frame.height/2
        noResultLabel.frame = CGRect(x: (width-width/1.2)/2, y: height/2-height/16, width: width/1.2, height: height/8)
    }
    
    @objc func sepetOnayButtonClicked() {
        let vc = PaymentVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func bindViewModel() {
            viewModel.loadSepetUrunler { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    let totalAmount = self?.viewModel.calculateTotalAmount() ?? 0
                    self?.toplamLabel.text = "Toplam: \(totalAmount) ₺"
                }
            }
        }
}

extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 0
        } else {
            return view.frame.height/6
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSepetUrunler
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            
            cell.isHidden = true
        }
        let model = viewModel.sepetUrun(at: indexPath.row)
        cell.model = model
        let resimAdi = model.yemek_resim_adi
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)")
        cell.yemekResim.sd_setImage(with: url)
        cell.yemekIsimLabel.text = model.yemek_adi
        cell.yemekAdetLabel.text = "Adet: \(model.yemek_siparis_adet)"
        cell.configureFiyat()
        cell.yemekIsimLabel.text = model.yemek_adi
        cell.yemekToplamFiyatLabel.text = "Toplam: \(model.yemek_fiyat) ₺"
        
        tableViewKontrol()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            viewModel.removeFromSepet(at: indexPath.row) {
                tableView.reloadData()
                let totalAmount = self.viewModel.calculateTotalAmount()
                self.toplamLabel.text = "Toplam: \(totalAmount) ₺"
            }
            self.sepetYemekler.remove(at: indexPath.row)
            var toplam = 0
            for yemek in self.sepetYemekler {
                guard let fiyatInt = Int(yemek.yemek_fiyat) else {
                    return
                }
                toplam += fiyatInt
            }
            self.tableView.reloadData()
            self.toplamLabel.text = "Toplam: \(toplam) ₺"
            
        default:
            break;
        }
    }
    
    func tableViewKontrol() {
        if viewModel.numberOfSepetUrunler < 2 {
            noResultLabel.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            noResultLabel.isHidden = true
        }
        
    }
    
}


