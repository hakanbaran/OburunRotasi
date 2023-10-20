//
//  DataPersistantManager.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 19.10.2023.
//

import Foundation
import UIKit
import CoreData


class DataPersistantManager {
    
    static let shared = DataPersistantManager()
    
    let context = appDelegate.persistentContainer.viewContext
    
    
    func addFavorite(model: TumYemekler, completion: @escaping(Result<Void, Error>) ->()) {
        
        guard let id = model.yemek_id else {
            return
        }
        
        let request: NSFetchRequest<YemeklerData>
        request = YemeklerData.fetchRequest()
        request.predicate = NSPredicate(format: "yemek_id == %@", id)
        do {
            let existing = try context.fetch(request)
            if existing.isEmpty {
                let newFood = YemeklerData(context: context)
                newFood.yemek_id = model.yemek_id
                newFood.yemek_adi = model.yemek_adi
                newFood.yemek_fiyat = model.yemek_fiyat
                newFood.yemek_resim_adi = model.yemek_resim_adi
                appDelegate.saveContext()
            } else {
                print("AYNI ISIM")
            }
            
        } catch {
            print("HATAA!!!!")
        }
    }
    
    func filterFavorite(id: String, completion: @escaping(Result<[YemeklerData], Error>) ->()) {
        let request: NSFetchRequest<YemeklerData>
        request = YemeklerData.fetchRequest()
        request.predicate = NSPredicate(format: "yemek_id == %@", id)
        do {
            let existing = try context.fetch(request)
            
            completion(.success(existing))
        } catch {
            print("HATAA!!!!")
        }
    }
    
    func fetchingFavorite(completion: @escaping(Result<[YemeklerData], Error>) ->()) {
        
        let request: NSFetchRequest<YemeklerData>
        request = YemeklerData.fetchRequest()
        do {
            let yemekler = try context.fetch(request)
            completion(.success(yemekler))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavorite(model: YemeklerData) {
        context.delete(model)
        appDelegate.saveContext()
    }
    
    func deleteFavoriToButton(id: String) {
        
        if let objectToDelete = try? context.fetch(YemeklerData.fetchRequest()) as? [YemeklerData] {
            
            let veriIdsi = id
            
            if let veriToDelete = objectToDelete.first(where: { $0.yemek_id == veriIdsi }) {
                context.delete(veriToDelete)
                
                do {
                            try context.save()
                        } catch {
                            print("Veri silinirken hata oluştu: \(error)")
                        }
            } else {
                print("Silinecek veri bulunamadı.")
            }
                    
            
            
        }
        
        
    }
    
    
    
}
