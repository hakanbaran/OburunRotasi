//
//  SepetVeriModel.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 20.10.2023.
//

import Foundation


struct SepetYemekler: Codable {
    let sepet_yemekler: [SepetYemek]?
    let success: Int?
}

struct SepetYemek: Codable {
    let kullanici_adi: String
    let sepet_yemek_id: String
    let yemek_adi: String
    let yemek_resim_adi: String
    let yemek_fiyat: String
    let yemek_siparis_adet: String
}



