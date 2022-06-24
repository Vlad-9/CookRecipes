//
//  FeedsViewController.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import UIKit
import SnapKit

protocol IFeedsViewController: UIViewController {

    func didLoadTrendingRecipes(with viewModel: [TrendingCardViewModel])
    func didLoadCategories(with model: [CategoryViewModel])
    func didLoadRecipeImage(_ image: UIImage ,at index: Int)
    func didLoadCategoriesImage(category: String, index: Int, image: UIImage)
}

extension FeedsViewController: ITrendingViewDelegate {

    func openRecipeDetails(at index: Int) {
        self.presenter.openTrendingRecipeDetails(at: index)
    }
}

extension FeedsViewController: ICategoryViewDelegate {

    func openRecipe(category: String, index: Int) {
        self.presenter.OpenCategoryRecipeDetails(with: category, at: index)
    }
}

final class FeedsViewController: UIViewController {

    // MARK: - Dependencies

    var presenter: IFeedsPresenter

    // MARK: - Constants

    private enum Constant {
        static let cellSpacing: CGFloat = 10
        static let reuseIdentifier = "Cell"
    }

    // MARK: - UI Elements
    
    private lazy var trendingView: ITrendingView = TrendingView()
    private lazy var categoryView: ICategoryView = CategoryView()

    private lazy var mainTtileLabel = CustomLabelBuilder()
        .setFont(AppFonts.bold24.font)
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(0)
        .setTextAlignment(.left)
        .setAdjustsFontSizeToFitWidth(true)
        .buildLabel()

    private lazy var subTtileLabel = CustomLabelBuilder()
        .setFont(AppFonts.bold20.font )
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(1)
        .setTextAlignment(.left)
        .buildLabel()

    private lazy var popularCategoryLabel = CustomLabelBuilder()
        .setFont(AppFonts.bold20.font)
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(1)
        .setTextAlignment(.left)
        .buildLabel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
        presenter.searchRecipe()
    }

    // MARK: - Initializer

    init(presenter: IFeedsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension FeedsViewController{

    func configure() {
        self.trendingView.delegate = self
        self.categoryView.delegate = self
        configureLabels()
        self.view.backgroundColor = .systemBackground
    }

    func configureLabels() {
        self.mainTtileLabel.text = "Find best recipes for cooking"
        self.subTtileLabel.text = "Trending now"
        self.popularCategoryLabel.text = "Popular category"
    }
    
    // MARK: - Layout

    func setupLayout() {
        setupTitleLabelsLayout()
        setupTrendingModuleLayout()
        setupCategoryModuleLayout()
    }

    func setupTitleLabelsLayout() {
        self.view.addSubview(mainTtileLabel)
        mainTtileLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().inset(146)
        }
        self.view.addSubview(subTtileLabel)
        subTtileLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalTo(mainTtileLabel.snp.bottom).offset(14)
        }
    }

    func setupTrendingModuleLayout() {
        self.view.addSubview(trendingView)
        trendingView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(subTtileLabel.snp.bottom).offset(20)
            make.height.equalTo(self.view.frame.height/4)
        }
    }

    func setupCategoryModuleLayout() {
        self.view.addSubview(popularCategoryLabel)
        popularCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(trendingView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(popularCategoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - IFeedsViewController protocol

extension FeedsViewController: IFeedsViewController {
    func didLoadTrendingRecipes(with viewModel: [TrendingCardViewModel]) {

        trendingView.configure(with: viewModel)
    }
    func didLoadCategories(with model: [CategoryViewModel]/*[String: [RecipeEntity]]*/) {
        self.categoryView.configureView(with: model)
    }
    func didLoadRecipeImage(_ image: UIImage, at index: Int) {
        trendingView.reloadImage(image, at: index)
    }

    func didLoadCategoriesImage(category: String, index: Int, image: UIImage) {

        categoryView.reloadImage(image, from: category, at: index)
    }
}
