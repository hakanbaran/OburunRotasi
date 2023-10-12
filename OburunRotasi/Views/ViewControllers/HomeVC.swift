//
//  ViewController.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    private let buttun: UIButton = {
        let button = UIButton()
        
        button.setTitle("Press", for: .normal)
        
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(buttun)
        buttun.addTarget(self, action: #selector(press), for: .touchUpInside)
        
    }
    
    @objc func press() {
        print("BASSSS")
        
        APICaller.shared.sepettekiYemekleriCek(kullaniciAdi: "admin")
         
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttun.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        
    }


}

