//
//  APICaller.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import Foundation
import Alamofire



class APICaller {
    
    static let shared = APICaller()
    
    
    public func getYemekler(completion: @escaping (Result<[Yemekler], Error>) -> ()) {
        guard let yemekAPIURL = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php") else {
            return
        }
        AF.request(yemekAPIURL, method: .get).response { response in
            if let data = response.data {
                do {
                    let resultResponse = try JSONDecoder().decode(YemeklerRsponse.self, from: data)
                    guard let result = resultResponse.yemekler else {
                        return
                    }
                    completion(.success(result))
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func veriKaydet(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        
        
        guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php") else {
                    return
                }
        let parameters: [String: Any] = [
            "yemek_adi": yemekAdi,
            "yemek_resim_adi": yemekResimAdi,
            "yemek_fiyat": yemekFiyat,
            "yemek_siparis_adet": yemekSiparisAdet,
            "kullanici_adi": kullaniciAdi
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                switch response.result {
                case .success(let value):
                    print("Başarılı cevap: \(value)")
                    // Burada işlem başarılı olduğunda ne yapılması gerektiğini tanımlayabilirsiniz.
                case .failure(let error):
                    print("Hata: \(error)")
                    // Hata durumunda ne yapılması gerektiğini tanımlayabilirsiniz.
                }
        }
    }
}

struct SepetYemek {
    let sepetYemekID: String
    let yemekAdi: String
    let yemekResimAdi: String
    let yemekFiyat: String
    let yemekSiparisAdet: String
    let kullaniciAdi: String

    init?(json: [String: Any]) {
        guard
            let sepetYemekID = json["sepet_yemek_id"] as? String,
            let yemekAdi = json["yemek_adi"] as? String,
            let yemekResimAdi = json["yemek_resim_adi"] as? String,
            let yemekFiyat = json["yemek_fiyat"] as? String,
            let yemekSiparisAdet = json["yemek_siparis_adet"] as? String,
            let kullaniciAdi = json["kullanici_adi"] as? String
        else {
            return nil
        }

        self.sepetYemekID = sepetYemekID
        self.yemekAdi = yemekAdi
        self.yemekResimAdi = yemekResimAdi
        self.yemekFiyat = yemekFiyat
        self.yemekSiparisAdet = yemekSiparisAdet
        self.kullaniciAdi = kullaniciAdi
    }
}



    
    
    

