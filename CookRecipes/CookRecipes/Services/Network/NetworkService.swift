//
//  NetworkService.swift
//  CookRecipes
//
//  Created by Влад on 08.06.2022.
//

import Foundation
import UIKit

enum NetworkServiceError: Error {
    case unableToMakeRequestURL
    case recipesDataMissing
    case imageDataMissing
    case brokenImageData
}

protocol INetworkService: AnyObject {
    func loadRecipes(
        named recipeName: String,
        completion: @escaping (Result<RecipeDTO, Error>) -> Void
    )
    func loadImage(
        from url: URL,
        completion: @escaping (Result<UIImage, Error>
        ) -> Void)
    func loadFeeds(completion: @escaping (Result<FeedsDTO, Error>) -> Void)
}

final class NetworkService {
    enum Endpoints {
        static let list = "https://tasty.p.rapidapi.com/recipes/list"
        static let headers = [
            "X-RapidAPI-Host": "tasty.p.rapidapi.com",
            "X-RapidAPI-Key": "730a3841e2msh915f198ab726c1ap1600c3jsn25b52c9d9960"
        ]
        static let feeds = "https://tasty.p.rapidapi.com/feeds/list"
        static let searchQueryItem = "q"
        static let size = "size"
        static let veg = "vegetarian"
        static let timezone = "timezone"
        static let timezonee = "+0700"
        static let size0 = "0"
        static let from = "from"
        static let vegf = "false"

    }
}

extension NetworkService: INetworkService {
    func loadFeeds(completion: @escaping (Result<FeedsDTO, Error>) -> Void)  {
        guard let urlRequest = makeURLRequest() else {
            completion(.failure(NetworkServiceError.unableToMakeRequestURL))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkServiceError.recipesDataMissing))
                return
            }
            do {
                let recipes
                = try JSONDecoder().decode(FeedsDTO.self, from: data)
                completion(.success(recipes))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }



    func loadRecipes(
        named recipeName: String,
        completion: @escaping (Result<RecipeDTO, Error>) -> Void
    ) {

        guard let urlRequest = makeURLRequest(forRecipeNamed: recipeName) else {
            completion(.failure(NetworkServiceError.unableToMakeRequestURL))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkServiceError.recipesDataMissing))
                return
            }
            do {
                let recipes
                = try JSONDecoder().decode(RecipeDTO.self, from: data)
                completion(.success(recipes))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    private func makeURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: Endpoints.feeds) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: Endpoints.size, value: Endpoints.size0),
            URLQueryItem(name: Endpoints.timezone, value: Endpoints.timezonee),
            URLQueryItem(name: Endpoints.veg, value: Endpoints.vegf),
            URLQueryItem(name: Endpoints.from, value: Endpoints.size0)
        ]
        guard let url = components.url  else { return nil }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Endpoints.headers
        return request
    }

    private func makeURLRequest(
forRecipeNamed recipeName: String
    ) -> URLRequest? {
        guard var components = URLComponents(string: Endpoints.list) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: Endpoints.searchQueryItem, value: recipeName)
        ]
        guard let url = components.url  else { return nil }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Endpoints.headers
        return request
    }

    func loadImage(
        from url: URL,
                   completion: @escaping (Result<UIImage, Error>
                   ) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkServiceError.imageDataMissing))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(NetworkServiceError.brokenImageData))
                return
            }
            completion(.success(image))
        }.resume()
    }
}
