//
//  RecipeViewController.swift
//  CookRecipes
//
//  Created by Влад on 17.06.2022.
//

import UIKit

protocol IRecipeViewController: AnyObject {
    func setData(with recipe: RecipeDetailsViewModel)
}

final class RecipeViewController: UIViewController {

    // MARK: - Dependencies

    private var presenter: IRecipeDetailsPresenter

    // MARK: - UI

    private lazy var scrollview = UIScrollView()
    private lazy var recipeView = UIView()

    // MARK: - Initializer

    init(presenter: IRecipeDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
        self.configureView()
        self.setupLayout()
    }
}

// MARK: - Private

private extension RecipeViewController {

    func configureView() {
        scrollview.delegate = self
        self.view.backgroundColor = .systemBackground
    }

    // MARK: - Layout

    func setupLayout() {
        setupScrollViewLayout()
        setupContentViewLayout()
    }

    func setupScrollViewLayout() {
        self.view.addSubview(scrollview)
        self.scrollview.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)

        }
    }

    func setupContentViewLayout() {
        self.scrollview.addSubview(recipeView)
        recipeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
}

// MARK: - IRecipeViewController protocol

extension RecipeViewController: IRecipeViewController {
    func setData(with recipe: RecipeDetailsViewModel) {
        self.recipeView = RecipeContentView(model: recipe, delegate: self)
    }
}

// MARK: - UIScrollViewDelegate protocol

extension RecipeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}
extension RecipeViewController: IrecipeContentViewDelegate {
    func saveRecipe() {
        
        self.presenter.saveRecipe()

        let alert = UIAlertController(title: "Recipe Saved", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
