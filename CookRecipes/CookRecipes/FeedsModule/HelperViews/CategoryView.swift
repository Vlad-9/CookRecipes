//
//  CategoryView.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

protocol ICategoryViewDelegate: AnyObject {
    func openRecipe(category: String, index: Int)
}

protocol ICategoryView: UIView {
    var delegate: ICategoryViewDelegate? { get set }
    func configureView(with model: [CategoryViewModel])
    func reloadImage(_ image: UIImage, from category: String, at index: Int)
    func viewDidLoad()
}

final class CategoryView: UIView {

    // MARK: - Constants

    private enum Constant {
        static let cellSpacing: CGFloat = 10
    }

    private enum Constraint {
        static let categoryViewHeight = 35
        static let categoriesRecipesCollectionViewTopOffset = 10
    }

    //  MARK: - Dependencies

    private var categoriesModels: [CategoryViewModel] = []
    var selectedCurrentKey = ""
    weak var delegate: ICategoryViewDelegate?

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewDidLoad()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private lazy var categoriesCollectionView = UICollectionView.init(frame: .zero,
                                                    collectionViewLayout: UICollectionViewFlowLayout.init())
    private lazy var categoriesRecipesCollectionView = UICollectionView(frame: CGRect.zero,
                                                           collectionViewLayout: UICollectionViewFlowLayout.init())

    // MARK: - Lifecycle

    func viewDidLoad() {
        configure()
        setupLayout()
    }
}
// MARK: - Private

private extension CategoryView {
    func configure() {
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.dataSource = self
        self.categoriesRecipesCollectionView.delegate = self
        self.categoriesRecipesCollectionView.dataSource = self
        categoriesCollectionView.contentInsetAdjustmentBehavior = .always
        categoriesRecipesCollectionView.contentInsetAdjustmentBehavior = .always
        categoriesCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.cellID)
        categoriesRecipesCollectionView.register(CardCollectionViewCell.self,
                                                 forCellWithReuseIdentifier: CardCollectionViewCell.cellID)
    }

    // MARK: - Layout

    func setupLayout() {

        if let layout = categoriesCollectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        self.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constraint.categoryViewHeight)
        }

        self.addSubview(categoriesRecipesCollectionView)
        categoriesRecipesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(Constraint.categoriesRecipesCollectionViewTopOffset)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - ICategoryView protocol

extension CategoryView: ICategoryView {
    func configureView(with model: [CategoryViewModel]){
        self.categoriesModels = model
        self.updateData()
    }

    func updateData() {
        categoriesCollectionView.reloadData()
        self.selectedCurrentKey = categoriesModels.first?.categoryName ?? ""
        categoriesRecipesCollectionView.reloadData()
    }

    func reloadImage(_ image: UIImage, from category: String, at index: Int) {
        guard let keyIndex = self.categoriesModels.firstIndex(where: {$0.categoryName == category}) else {return}
        self.categoriesModels[keyIndex].recipes[index].image = image
        categoriesRecipesCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol

extension CategoryView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.showsHorizontalScrollIndicator = false
        return Constant.cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoriesCollectionView {

           let safeFrame = collectionView.safeAreaLayoutGuide.layoutFrame
            let nameLabel = CustomLabelBuilder().setTextAlignment(.center).setTextColor(.white).setFont(.systemFont(ofSize: 16, weight: .bold)).buildLabel()

            nameLabel.text = categoriesModels[indexPath.row].categoryName
            nameLabel.sizeToFit()
            return CGSize(width: nameLabel.frame.width * 1.3, height: safeFrame.height/1.1)

        } else {
            let safeFrame = collectionView.safeAreaLayoutGuide.layoutFrame
            let size = CGSize(width: safeFrame.width/2.5, height: safeFrame.height/1.1)
            return size
        }
    }

}

// MARK: - UICollectionViewDataSource protocol

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.categoriesCollectionView {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: CategoryCollectionViewCell.cellID,
                                                                 for: indexPath as IndexPath
            ) as? CategoryCollectionViewCell
            else { return UICollectionViewCell() }
            let categoryName = categoriesModels[indexPath.row].categoryName
            cell.configureCell(with: categoryName)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CardCollectionViewCell.cellID,
                for: indexPath as IndexPath
            ) as? CardCollectionViewCell
            else { return UICollectionViewCell() }
            guard let index = self.categoriesModels.firstIndex(where: {$0.categoryName == selectedCurrentKey}) else {return UICollectionViewCell()}
             let model = self.categoriesModels[index]
            cell.configureCell(model: model.recipes[indexPath.row])

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return self.categoriesModels.count
        } else {
            guard let index = self.categoriesModels.firstIndex(where: {$0.categoryName == selectedCurrentKey}) else {return 0}
             let model = self.categoriesModels[index]
            return model.recipes.count
        }
    }
}

// MARK: - UICollectionViewDelegate protocol

extension CategoryView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoriesCollectionView{
            self.selectedCurrentKey = categoriesModels[indexPath.row].categoryName
            self.categoriesRecipesCollectionView.reloadData()
            self.categoriesRecipesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        } else {
            delegate.self?.openRecipe(category: selectedCurrentKey, index: indexPath.row)
        }
    }
}
