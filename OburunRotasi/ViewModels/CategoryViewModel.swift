//
//  CategoryViewModel.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 21.10.2023.
//

import Foundation

class CategoryViewModel {
    
    var yemeklerListesi: [TumYemekler] = []
    
    var numberOfYemekler: Int {
            return yemeklerListesi.count
        }
    
    func yemek(at index: Int) -> TumYemekler {
            return yemeklerListesi[index]
        }
    
    func downloadTumYemekler(completion: @escaping (Result<Void, Error>) -> Void) {
            APICaller.shared.tumYemekler { result in
                switch result {
                case .success(let yemeklerListesi):
                    self.yemeklerListesi = yemeklerListesi
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func checkFavoriteStatus(for yemek: TumYemekler, completion: @escaping (Bool) -> Void) {
            if let id = yemek.yemek_id {
                DataPersistantManager.shared.filterFavorite(id: id) { result in
                    switch result {
                    case .success(let filterFood):
                        completion(!filterFood.isEmpty)
                    case .failure:
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
    
}
