//
//  ProfileVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 12.10.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.separatorStyle = .none
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        return tableView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(hex: "#162544")
        imageView.image = UIImage(systemName: "person.circle")
        
        return imageView
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Çıkış Yap", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(hex: "#162544")
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hakan Baran"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "hakanbaran.developer@gmail.com"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let sectionsData = [
            ["Profil Fotoğrafı Değiştir", "Kullanıcı Adı Değiştir"],
            ["Kayıtlı Yemekler", "Yemek Tarifleri"],
            ["Bildirim ve Ses", "Gizlilik ve Güvenlik", "Görünüm", "Veri Depolama"]
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width/1.9))
        headerView.backgroundColor = UIColor(hex: "#0C1B3A")
        tableView.tableHeaderView = headerView
        
        headerView.addSubview(profileImageView)
        headerView.addSubview(userNameLabel)
        headerView.addSubview(userEmailLabel)
        
        view.addSubview(logOutButton)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let height = view.frame.height
        
        tableView.frame = CGRect(x: 0, y: 0, width: width, height: height/1.2)
        
        profileImageView.frame = CGRect(x: width/2-width/6 , y: -width/20, width: width/3, height: width/3)
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        
        userNameLabel.frame = CGRect(x: 0, y: width/3-width/20, width: width, height: width/5)
        
        userEmailLabel.frame = CGRect(x: 0, y: width/3+width/10-width/20, width: width, height: width/5)
        
        logOutButton.frame = CGRect(x: width/2-width/4.4, y: height-height/6, width: width/2.2, height: width/8)
        
        logOutButton.layer.cornerRadius = logOutButton.frame.height/2
        
        
    }
    
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = sectionsData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}
