//
//  Extension.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

extension UIView {
    func addGradient(with layer: CAGradientLayer) {
        layer.frame = self.bounds
        let colorTop = UIColor(white: 0, alpha: 0.1).cgColor
        let colorBottom = UIColor(white: 0, alpha: 1.0).cgColor
        layer.colors = [colorTop,colorBottom]
        layer.locations = [0.0, 1.0]
        self.layer.insertSublayer(layer, at: 0)
    }
}


