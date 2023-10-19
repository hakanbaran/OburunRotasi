//
//  FoodDetailsVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 18.10.2023.
//

import UIKit
import SDWebImage

class FoodDetailsVC: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 8
        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/ayran.png")
        imageView.sd_setImage(with: url)
        imageView.backgroundColor = UIColor(hex: "#248CB3")
        imageView.alpha = 0.7
        
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 3
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        return imageView
    }()
    
    let detailView = UIView()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tavuk Izgara"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "25 ₺"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "30 Dakika"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.backgroundColor = UIColor(hex: "#248CB3")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.textAlignment = .center
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Hemen Teslimat"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.backgroundColor = UIColor(hex: "#248CB3")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.textAlignment = .center
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "%20 İndirim"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.backgroundColor = UIColor(hex: "#248CB3")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.textAlignment = .center
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Sipariş Notunu Giriniz..."
        textView.textColor = .secondaryLabel
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 15
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        textView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.backgroundColor = UIColor(hex: "#162544")
        return textView
    }()
    
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        button.backgroundColor = UIColor(hex: "#162544")
        button.titleLabel?.textAlignment = .center
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        button.backgroundColor = UIColor(hex: "#162544")
        button.titleLabel?.textAlignment = .center
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        return button
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let addBasketbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = UIColor(hex: "#162544")
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        return button
    }()
    
    var siparisSayısı = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        textView.delegate = self
        stackView.addArrangedSubview(detailView)
        
        detailView.addSubview(imageView)
        detailView.addSubview(nameLabel)
        detailView.addSubview(priceLabel)
        detailView.addSubview(label1)
        detailView.addSubview(label2)
        detailView.addSubview(label3)
        detailView.addSubview(textView)
        detailView.addSubview(minusButton)
        detailView.addSubview(plusButton)
        detailView.addSubview(scoreLabel)
        detailView.addSubview(addBasketbutton)
        view.addSubview(stackView)
        
        detailView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        detailView.addGestureRecognizer(tapGestureRecognizer)
        minusButton.addTarget(self, action: #selector(siparisAzalt), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(siparisArttır), for: .touchUpInside)
        
        addBasketbutton.addTarget(self, action: #selector(addBasketButtonClicked), for: .touchUpInside)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureStackViewConstraints()
        configureConstraints()
    }
    
    func configureStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureConstraints() {
        let width = view.frame.width
        detailView.widthAnchor.constraint(equalToConstant: width).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: width*1.5).isActive = true
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: width/1.8)
        nameLabel.frame = CGRect(x: width/20, y: width/1.8+width/20, width: width/2, height: width/15)
        priceLabel.frame = CGRect(x: width-width/2-width/20, y: width/1.8+width/20, width: width/2, height: width/15)
        label1.frame = CGRect(x: width/20, y: width/1.8+width/10+width/15, width: width/4, height: width/15)
        label2.frame = CGRect(x: width/2-width/6, y: width/1.8+width/10+width/15, width: width/3, height: width/15)
        label3.frame = CGRect(x: width-width/20-width/4, y: width/1.8+width/10+width/15, width: width/4, height: width/15)
        textView.frame = CGRect(x: width/20, y: width/1.8+width/10+width/15+width/15+width/20, width: width-width/10, height: width/3)
        minusButton.frame = CGRect(x: width/20, y:width/1.8+width/10+width/15+width/15+width/10+width/3 , width: width/10, height: width/10)
        scoreLabel.frame = CGRect(x: width/20+width/13+width/20, y:width/1.8+width/10+width/15+width/15+width/10+width/3 , width: width/10, height: width/10)
        plusButton.frame = CGRect(x: width/20+width/10+width/10+width/20, y:width/1.8+width/10+width/15+width/15+width/10+width/3 , width: width/10, height: width/10)
        addBasketbutton.frame = CGRect(x: width-width/20-width/2.5, y: width/1.8+width/10+width/15+width/15+width/10+width/3, width: width/2.5, height: width/10)
        minusButton.layer.cornerRadius = minusButton.frame.width/2
        plusButton.layer.cornerRadius = minusButton.frame.width/2
        addBasketbutton.layer.cornerRadius = addBasketbutton.frame.height/2
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    @objc func siparisAzalt() {
        siparisSayısı -= 1
        scoreLabel.text = String(siparisSayısı)
    }
    @objc func siparisArttır() {
        siparisSayısı += 1
        scoreLabel.text = String(siparisSayısı)
    }
    
    @objc func addBasketButtonClicked() {
            self.dismiss(animated: true)
    }
}

extension FoodDetailsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Sipariş Notunu Giriniz..." {
            textView.text = ""
            textView.textColor = UIColor.lightGray
        }
    }
}
