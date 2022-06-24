//
//  FeedsPresenter.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import UIKit

protocol IFeedsPresenter {
    func openRecipeDetails(model: RecipeEntity)
    func openTrendingRecipeDetails(at index: Int)
    func OpenCategoryRecipeDetails(with category: String ,at recipeIndex: Int)
    func searchRecipe()
}

final class FeedsPresenter {

    // MARK: - Dependencies

    weak var view: IFeedsViewController?
    var trendingModels: [RecipeEntity] = []
    var categoriesEntites: [FeedEntity] = []
    private var interactor: IFeedsInteractor?
    private var router: IFeedsRouter?

    // MARK: - Initializer

    init( interactor: IFeedsInteractor, router: IFeedsRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Private

private extension FeedsPresenter {
    func fetchCategoryImages() {
        for models in categoriesEntites {
            let name = models.name
            for index in 0..<models.items.count {
                guard let url = models.items[index].imageURL
                else {return}
                interactor?.loadImage(from: url) { [weak self] result in
                    switch result {
                    case .success(let data):
                        guard let firstIndex = self?.categoriesEntites.firstIndex(where: {$0.name == name}) else {return}
                        self?.categoriesEntites[firstIndex].items[index].image = data
                        DispatchQueue.main.async {
                            self?.view?.didLoadCategoriesImage(category: name,
                                                               index: index,
                                                               image: data)
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

    func fetchTrendingImages() {
        for index in 0..<trendingModels.count{
            guard let url = trendingModels[index].imageURL else {return}
            interactor?.loadImage(from: url) { [weak self] result in
                switch result {
                case .success(let newImage):
                    self?.trendingModels[index].image = newImage
                    DispatchQueue.main.async {
                        self?.view?.didLoadRecipeImage(newImage, at: index)
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
// MARK: - IFeedsPresenter protocol

extension FeedsPresenter: IFeedsPresenter {
    func openRecipeDetails(model: RecipeEntity) {
        guard let view = self.view else {return}
        self.router?.openRecipeDetails(viewController: view,
                                       model: model)
    }

    func openTrendingRecipeDetails(at index: Int) {
        self.openRecipeDetails(model: trendingModels[index])
    }

    func OpenCategoryRecipeDetails(with category: String ,at recipeIndex: Int) {
        guard let firstIndex = self.categoriesEntites.firstIndex(where: {$0.name == category}) else {return}
        self.openRecipeDetails(model: self.categoriesEntites[firstIndex].items[recipeIndex])
    }
    func searchRecipe() { //fetch feeds
        interactor?.fetchFeeds { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let models):
                var categoryViewModels: [CategoryViewModel] = []
                for element in models {
                    if element.category == "Daily" || element.category == "Seasonal"  {
                        self.categoriesEntites.append(element)
                        categoryViewModels.append(CategoryViewModel(from: element))
                    }
                }

                self.fetchCategoryImages()
                guard let model = models.first(where: {$0.category == "Trending"})?.items else { return }
                self.trendingModels = model
                self.fetchTrendingImages()
                var trendingViewModels: [TrendingCardViewModel] = []
                for element in model {
                    trendingViewModels.append(TrendingCardViewModel(from: element))
                }
                DispatchQueue.main.async {
                    self.view?.didLoadCategories(with: categoryViewModels )
                    self.view?.didLoadTrendingRecipes(with: trendingViewModels)
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    print("Presenter  load data: \(error.localizedDescription)")
                }
            }
        }
    }
}
