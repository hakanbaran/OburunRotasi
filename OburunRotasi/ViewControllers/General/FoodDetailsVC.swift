//
//  FoodDetailsVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 18.10.2023.
//

import UIKit
import SDWebImage

class FoodDetailsVC: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/ayran.png")
        imageView.sd_setImage(with: url)
        
        imageView.backgroundColor = UIColor(hex: "#248CB3")
        
        return imageView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        
        

        
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let height = view.frame.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: width , height: height/3)
        
        
    }
    

    

}
