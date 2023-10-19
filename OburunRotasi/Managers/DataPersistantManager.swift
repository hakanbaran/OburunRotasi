//
//  DataPersistantManager.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 19.10.2023.
//

import Foundation
import UIKit


class DataPersistantManager {
    
    static let shared = DataPersistantManager()
    
    
    func addFavorite(model: Yemekler, completion: @escaping(Result<Void, Error>) ->()) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = YemeklerData(context: context)
        
        item.yemek_id = model.yemek_id
        item.yemek_adi = model.yemek_adi
        item.yemek_fiyat = model.yemek_fiyat
        item.yemek_resim_adi = model.yemek_resim_adi
        
        do {
            try context.save()
            completion(.success(()))
            print("Kayıt BAŞARILIIII")
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
    
    
    
}
