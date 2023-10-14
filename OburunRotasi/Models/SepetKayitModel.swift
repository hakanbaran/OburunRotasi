//
//  SepetKayitModel.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import Foundation

struct KayitSepetResponse: Codable {
    var sepet_yemekler: [KayitSepet]?
    var success: Int?
}

struct KayitSepet: Codable {
    var yemek_adi: String?
    var yemek_resim_adi: String?
    var yemek_fiyat: Int?
    var yemek_siparis_adet: Int?
    var kullanici_adi: String?
}
