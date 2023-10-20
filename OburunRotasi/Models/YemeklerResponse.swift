//
//  YemeklerResponse.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import Foundation

struct YemeklerResponse: Codable {
    let yemekler: [TumYemekler]?
    let success: Int?
}

struct TumYemekler: Codable {
    let yemek_id: String?
    let yemek_adi: String?
    let yemek_resim_adi: String
    let yemek_fiyat: String?
}
