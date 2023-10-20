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
    var yemek_id: String?
    var yemek_adi: String?
    var yemek_resim_adi: String
    var yemek_fiyat: String?
}
