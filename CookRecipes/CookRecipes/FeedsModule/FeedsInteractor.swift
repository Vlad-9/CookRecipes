//
//  FeedsInteractor.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import UIKit

protocol IFeedsInteractor {
    func loadImage(
        from url: URL,
        completion: @escaping(Result<UIImage, Error>
        ) -> Void)
    func fetchFeeds(
        completion: @escaping (Result<[FeedEntity], Error>) -> Void
    )
}

final class FeedsInteractor {

    // MARK: - Dependencies

    var networkService: INetworkService

    // MARK: - Initializer

    init(networkService: INetworkService) {
        self.networkService = networkService
    }
}

// MARK: - IFeedsInteractor protocol

extension FeedsInteractor: IFeedsInteractor {
    func loadImage(
        from url: URL,
        completion: @escaping(Result<UIImage, Error>) -> Void
    ) {
        self.networkService.loadImage(from: url, completion: completion)
    }

    func fetchFeeds(
        completion: @escaping (Result<[FeedEntity], Error>
        ) -> Void) {
        self.networkService.loadFeeds { (result: Result<FeedsDTO, Error>) in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    var arrayEntities = [FeedEntity]()

                    for model in models.results {
                        arrayEntities.append(FeedEntity(from: model))
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
