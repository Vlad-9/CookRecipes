//
//  SearchInteractor.swift
//  CookRecipes
//
//  Created by Влад on 16.06.2022.
//

import UIKit

protocol ISearchInteractor: AnyObject {
    
    func loadImage(
        from url: URL,
        completion: @escaping(Result<UIImage, Error>
        ) -> Void)
    func fetchRecipes(
        named recipeName: String,
        completion: @escaping (Result<[RecipeEntity], Error>) -> Void
    )
}

final class SearchInteractor {

    // MARK: - Dependencies

    var networkService: INetworkService

    // MARK: - Initializer

    init(networkService: INetworkService) {
        self.networkService = networkService
    }
}

// MARK: - iSearchInteractor protocol

extension SearchInteractor: ISearchInteractor {

    func loadImage(
        from url: URL,
        completion: @escaping(Result<UIImage, Error>) -> Void
    ) {
        self.networkService.loadImage(from: url, completion: completion)
    }

    func fetchRecipes(
        named text: String,
        completion: @escaping (Result<[RecipeEntity], Error>
    ) -> Void) {
        self.networkService.loadRecipes(
            named: text
        ) { (result: Result<RecipeDTO, Error>) in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    var arrayEntities = [RecipeEntity]()
                    var newModels = models
                    newModels.results.removeAll(where: {$0.instructions == nil})
                    for model in newModels.results {
                        arrayEntities.append(RecipeEntity(from: model))
                    }
                    completion(.success(arrayEntities))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Interactor: \(error.localizedDescription)")
                }
            }
        }
    }
}
