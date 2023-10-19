//
//  StringExtension.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 19.10.2023.
//

import Foundation


extension String {
    func extractValue(forKey key: String) -> String? {
        if let range = self.range(of: "\(key): ") {
            let startIndex = range.upperBound
            let substring = self[startIndex...]
            if let endIndex = substring.firstIndex(of: ",") {
                return String(substring[..<endIndex])
            }
        }
        return nil
    }
}
