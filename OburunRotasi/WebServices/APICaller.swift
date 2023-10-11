//
//  APICaller.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import Foundation
import Alamofire

struct YemeklerRsponse: Codable {
    let yemekler: [Yemekler]?
    let success: Int?
}

// MARK: - Yemekler
struct Yemekler: Codable {
    let yemekID, yemekAdi, yemekResimAdi, yemekFiyat: String?
}


class APICaller {
    
    static let shared = APICaller()
    
    
    public func getYemekler() {
        guard let yemekAPIURL = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php") else {
            return
        }
        
        
//        URLSession.shared.dataTask(with: yemekAPIURL) { data, response, error in
//            do {
////                let result = try JSONDecoder().decode(YemeklerRsponse.self, from: data!)
////                print(result)
//                
//                let result = try JSONSerialization.jsonObject(with: data!)
//                print(result)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: yemekAPIURL)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            do {
                let results = try JSONSerialization.jsonObject(with: data)
                print("GAETTSSSSS")
                print(results)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
        
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
//            guard let data = data, error == nil else {return}
//            
//            do {
//                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
//                completion(.success(results.results))
////                print("Get Data...")
//            } catch {
//                completion(.failure(APIError.failedTogetData))
//            }
//        }
//        task.resume()
        
        
        
//        AF.request(yemekAPIURL).response { response in
//            switch response.result {
//            case .success(let data):
//                if let jsonData = data {
//                    do {
//                        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
//                            if let yemekler = json["yemekler"] as? [[String: Any]] {
//                                for yemek in yemekler {
//                                    if let yemekAdi = yemek["yemek_adi"] as? String,
//                                       let yemekFiyat = yemek["yemek_fiyat"] as? String {
//                                        print("Yemek Adı: \(yemekAdi), Fiyat: \(yemekFiyat)")
//                                    }
//                                }
//                            }
//                        }
//                    } catch {
//                        print("JSON verisi işlenirken hata oluştu: \(error)")
//                    }
//                }
//            case .failure(let error):
//                print("Hata oluştu: \(error)")
//            }
//        }
    }
}
