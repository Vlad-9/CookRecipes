//
//  FeedsAssembly.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import Foundation
import UIKit

enum FeedsAssembly {
    static func createDetailsViewController() -> UIViewController {
        let router = FeedsRouter()
        let interactor = FeedsInteractor(networkService: NetworkService())
        let presenter = FeedsPresenter(interactor: interactor, router: router)
        let view = FeedsViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
