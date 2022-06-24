//
//  Fonts.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

enum AppFonts {
    case regular12
    case regular14
    case regular16
    case regular20
    case regular24
    case regular32
    case bold12
    case bold14
    case bold16
    case bold20
    case bold24
    case bold32
    var font: UIFont? {

        switch self {
        case .regular12:
            return UIFont(name: "Poppins-Regular", size: 12)
        case .regular14:
            return UIFont(name: "Poppins-Regular", size: 14)
        case .regular16:
            return UIFont(name: "Poppins-Regular", size: 16)
        case .regular20:
            return UIFont(name: "Poppins-Regular", size: 20)
        case .regular24:
            return UIFont(name: "Poppins-Regular", size: 24)
        case .regular32:
            return UIFont(name: "Poppins-Regular", size: 32)
        case .bold12:
            return UIFont(name: "Poppins-Bold", size: 12)
        case .bold14:
            return UIFont(name: "Poppins-Bold", size: 14)
        case .bold16:
            return UIFont(name: "Poppins-Bold", size: 16)
        case .bold20:
            return UIFont(name: "Poppins-Bold", size: 20)
        case .bold24:
            return UIFont(name: "Poppins-Bold", size: 24)
        case .bold32:
            return UIFont(name: "Poppins-Bold", size: 32)
        }
    }
}
