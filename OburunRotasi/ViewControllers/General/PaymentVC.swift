//
//  PaymentVC.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 22.10.2023.
//

import UIKit
import WebKit

class PaymentVC: UIViewController {
    
    
    private let webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.backgroundColor = .red
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "https://github.com/hakanbaran") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        
    }
}
