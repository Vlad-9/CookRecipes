//
//  SearchPresenter.swift
//  CookRecipes
//
//  Created by Влад on 16.06.2022.
//

import Foundation
import UIKit

protocol ISearchPresenter: AnyObject {
    func viewWillAppear()
    func searchRecipe(named recipeName: String)
    func openRecipeDetails(at index: Int)
}

final class SearchPresenter {

    // MARK: - Constant

    enum Constant {
      //  static let numberOfDays = 6
    }

    // MARK: - Dependencies

    weak var view: ISearchView? //i
    private var interactor: ISearchInteractor?
    private var router: ISearchRouter?
    private var networkService = NetworkService()
    var models = [RecipeEntity]()

    // MARK: - Initializer

    init(interactor: ISearchInteractor, router: ISearchRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Private

private extension SearchPresenter {
    func fetchImages() {
        for index in 0..<models.count {
            guard let url = models[index].imageURL else {return}
            interactor?.loadImage(from: url) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.models[index].image = data
                    DispatchQueue.main.async {
                        self?.view?.reloadImage(data, at: index)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Presenter Load Image: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

// MARK: - ISearchPresenter protocol

extension SearchPresenter: ISearchPresenter {
    func viewWillAppear() {
    }

    func searchRecipe(named recipeName: String) {
        interactor?.fetchRecipes(named: recipeName) { [weak self] result in

            switch result {
            case .success(let models):
                self?.models = models
                var arrayViewModels: [SearchViewModel] = []
                for element in models {
                    arrayViewModels.append(SearchViewModel(from: element))
                }
                self?.view?.configure(with: arrayViewModels)
                self?.fetchImages()
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Presenter  load data: \(error.localizedDescription)")
                }

            }
        }
    }

    func openRecipeDetails(at index: Int) {
        guard let view = self.view else {return}
        self.router?.openRecipeDetails(viewController: view,
                                       model: models[index])
    }
}
