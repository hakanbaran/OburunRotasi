//
//  YemeklerResponse.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 11.10.2023.
//

import Foundation

struct YemeklerRsponse: Codable {
    let yemekler: [Yemekler]?
    let success: Int?
}

struct Yemekler: Codable {
    let yemek_id: String?
    let yemek_adi: String?
    let yemek_resim_adi: String
    let yemek_fiyat: String?
}
