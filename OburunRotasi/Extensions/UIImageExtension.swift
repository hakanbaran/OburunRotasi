//
//  UIImageExtension.swift
//  OburunRotasi
//
//  Created by Hakan Baran on 30.10.2023.
//

import Foundation
import UIKit


extension UIImage {
    func scaledToHalf() -> UIImage? {
        let newSize = CGSize(width: size.width * 1.5, height: size.height * 1.5)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
