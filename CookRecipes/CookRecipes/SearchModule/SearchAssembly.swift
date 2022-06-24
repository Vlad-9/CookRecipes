//
//  SearchAssembly.swift
//  CookRecipes
//
//  Created by Влад on 16.06.2022.
//

import UIKit

enum SearchAssembly {
    static func createDetailsViewController() -> UIViewController {
        let router = SearchRouter()
        let networkService = NetworkService()
        let interactor = SearchInteractor(networkService: networkService)
        let presenter = SearchPresenter(interactor: interactor, router: router)
        let view = SearchViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
