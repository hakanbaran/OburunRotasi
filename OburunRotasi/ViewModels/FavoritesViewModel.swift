//
//  FavoritesViewModel.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 21.10.2023.
//

import Foundation

import Foundation

class FavoritesViewModel {
    private var favoriYemekler: [YemeklerData] = []

    var numberOfFavorites: Int {
        return favoriYemekler.count
    }

    func favorite(at index: Int) -> YemeklerData {
        return favoriYemekler[index]
    }

    func loadFavoriteYemekler() {
        DataPersistantManager.shared.fetchingFavorite { result in
            switch result {
            case .success(let yemeklerDatas):
                self.favoriYemekler = yemeklerDatas
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func removeFromFavorites(at index: Int) {
        let favoriYemek = favoriYemekler[index]
        DataPersistantManager.shared.deleteFavorite(model: favoriYemek)
        favoriYemekler.remove(at: index)
    }
}

