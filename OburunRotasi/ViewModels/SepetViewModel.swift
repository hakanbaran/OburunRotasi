//
//  BasketViewModel.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 21.10.2023.
//

import Foundation


class SepetViewModel {
    private var sepetUrunler: [SepetYemek] = []

    var numberOfSepetUrunler: Int {
        return sepetUrunler.count
    }

    func sepetUrun(at index: Int) -> SepetYemek {
        return sepetUrunler[index]
    }

    func loadSepetUrunler(completion: @escaping () -> Void) {
        APICaller.shared.sepettekiYemekleriCek(kullaniciAdi: "hakanbaran2") { result in
            switch result {
            case .success(let yemekler):
                self.sepetUrunler = yemekler
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func removeFromSepet(at index: Int, completion: @escaping () -> Void) {
        let model = sepetUrunler[index]
        let id = Int(model.sepet_yemek_id)!
        APICaller.shared.sepettekiYekeleriSil(sepet_yemek_id: id, kullanici_adi: "hakanbaran2")
            self.sepetUrunler.remove(at: index)
    }
    
    func calculateTotalAmount() -> Int {
        var totalAmount = 0
        for urun in sepetUrunler {
            if let fiyatInt = Int(urun.yemek_fiyat), let adet = Int(urun.yemek_siparis_adet) {
                totalAmount += fiyatInt * adet
            }
        }
        return totalAmount
    }
}


