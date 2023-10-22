//
//  LaunchScreen.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 22.10.2023.
//

import UIKit

class LaunchScreen: UIViewController {
    
    private let animationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OburunRotası")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "OBURUN"
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appNameLabel2: UILabel = {
        let label = UILabel()
        label.text = "ROTASI"
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#0C1B3A")
        
        view.addSubview(animationView)
        animationView.addSubview(imageView)
        animationView.addSubview(appNameLabel)
        animationView.addSubview(appNameLabel2)
        
        iconAnimation()
        configureConstraints()
    }
    
    func iconAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseIn, animations: {
            self.animationView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (completed) in
        }
    }
    
    func configureConstraints() {
        
        let width = view.frame.width
        
        let animationConstraints = [
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: width/2),
            animationView.heightAnchor.constraint(equalToConstant: width/2)
        ]
        
        let imageViewConstaints = [
            imageView.topAnchor.constraint(equalTo: animationView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: animationView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -50)
        ]
        
        let labelConstraints = [
            appNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -width/20),
            appNameLabel.centerXAnchor.constraint(equalTo: animationView.centerXAnchor)
        ]
        
        let label2Constraints = [
            appNameLabel2.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor),
            appNameLabel2.centerXAnchor.constraint(equalTo: animationView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(animationConstraints)
        NSLayoutConstraint.activate(imageViewConstaints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(label2Constraints)
        
        
    }
    
    
}
