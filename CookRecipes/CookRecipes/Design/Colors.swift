//
//  Colors.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

enum Colors {
    case white
    case whiteBackground
    case gray
    case neutral90
    case primary50
    case neutral40
    case primary40
    case rating100
    case neutral10

    var value: UIColor {
        switch self {
        case .white:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case .whiteBackground:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        case .gray:
            return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        case .neutral90:
            return UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        case .neutral10:
            return UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        case .primary50:
            return UIColor(red: 226/255, green: 62/255, blue: 62/255, alpha: 1)
        case .neutral40:
            return UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
        case .primary40:
            return UIColor(red: 238/255, green: 139/255, blue: 139/255, alpha: 1)
        case .rating100:
            return UIColor(red: 255/255, green: 182/255, blue: 97/255, alpha: 1)
        }
    }

    var cgColor: CGColor {
        return self.value.cgColor
    }
}
