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
    
    private let kontrolURLString = "http://kasimadalan.pe.hu/yemekler/kontrol.php"
    
    public func tumYemekler(completion: @escaping (Result<[TumYemekler], Error>) -> ()) {
        guard let yemekAPIURL = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php") else {
            return
        }
        AF.request(yemekAPIURL, method: .get).response { response in
            if let data = response.data {
                do {
                    let resultResponse = try JSONDecoder().decode(YemeklerResponse.self, from: data)
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
    
    func sepeteYemekKaydet(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        
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
        AF.request(url, method: .post, parameters: parameters).response { response in
                
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepettekiYemekleriCek(kullaniciAdi: String, completion: @escaping (Result<[SepetYemek], Error>) -> ()) {
        
        guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php") else {
            return
        }
        let parameters: [String: Any] = [
            "kullanici_adi": kullaniciAdi
        ]
        AF.request(url, method: .post, parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let sepetYemekler = try JSONDecoder().decode(SepetYemekler.self, from: data)
                    
                    guard let yemekler = sepetYemekler.sepet_yemekler else {
                        return
                    }
                    completion(.success(yemekler))
                } catch {
                    debugPrint("JSON çözümleme hatası: \(error)")
                }
            } else {
                print("Veri alınamadı")
            }
        }
    }

    func sepettekiYekeleriSil(sepet_yemek_id: Int, kullanici_adi: String) {
        
        guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php") else {
            return
        }
        let parameters: [String: Any] = [
            "kullanici_adi": kullanici_adi,
            "sepet_yemek_id": sepet_yemek_id
        ]
        
        AF.request(url, method: .post, parameters: parameters).response { response in
            
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


