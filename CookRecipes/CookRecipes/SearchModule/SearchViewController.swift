//
//  SearchViewController.swift
//  CookRecipes
//
//  Created by Влад on 16.06.2022.
//

import UIKit

protocol ISearchView: UIViewController {

    func configure(with viewModel: [SearchViewModel])
    func reloadImage(_ image: UIImage, at index: Int)
}

final class SearchViewController: UIViewController {

    // MARK: - Texts

    private enum Texts {
        static let searchTFPlaceholder = "Search here"
    }

    // MARK: - Constants

    private enum Constant {
        static let cellSpacing: CGFloat = 1
        static let reuseIdentifier = "Cell"
    }

    // MARK: - Constraints

    private enum Constants {
        static let horisontalSearchOffset = 30
        static let searchHeight = 50
        static let emptyViewWidth = 16

        static let topImageViewOffset = 36
        static let imageViewSize = 142

        static let cornerRadius: CGFloat = 15
        static let widgetViewOffset = 36

        static let buttonTopOffset = 35
        static let buttonHorisontalOffset = 97
    }

    // MARK: - Dependencies

    var presenter: ISearchPresenter
    var viewModel: [SearchViewModel] = []

    // MARK: - Initializer

    init(presenter: ISearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private lazy var searchTitleLabel = CustomLabelBuilder()
        .setTextColor(Colors.neutral90.value)
        .setText("Search recipes")
        .setFont(AppFonts.bold24.font)
        .buildLabel()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: Constant.reuseIdentifier)
        return collectionView
    }()
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Colors.white.value
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        textField.placeholder = Texts.searchTFPlaceholder
        let emptyView = UIView(frame: .init(x: .zero, y: .zero, width: Constants.emptyViewWidth, height: .zero))
        textField.leftViewMode = .always
        textField.leftView = emptyView
        textField.rightViewMode = .always
        textField.rightView = emptyView
        textField.tintColor = Colors.primary50.value
        textField.delegate = self
        return textField
    }()

    // MARK: - LifeCycle

    override func viewDidLoad () {
        self.configureView()
        self.setupLayout()
        self.presenter.viewWillAppear()
    }
}

// MARK: - Private

private extension SearchViewController {
    func configureView() {
        self.configureTextField()
        self.view.backgroundColor = .systemBackground
    }

    // MARK: - Layout

    func setupLayout() {
        self.setupTitleLayout()
        self.setupSearchTextFieldLayout()
        self.setupResultCollectionViewLayout()
    }

    func setupTitleLayout() {
        self.view.addSubview(self.searchTitleLabel)
        searchTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    func setupSearchTextFieldLayout() {
        self.view.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(searchTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(Constants.searchHeight)
        }
    }

    func setupResultCollectionViewLayout() {
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func configureTextField() {
        self.searchTextField.layer.borderColor = UIColor.systemRed.cgColor
        self.searchTextField.layer.borderWidth = 1
        self.searchTextField.layer.masksToBounds = false
    }
}
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.presenter.searchRecipe(named: textField.text ?? "")
        view.endEditing(true)
        return true
    }
}

// MARK: - ISearchView protocol

extension SearchViewController: ISearchView {

    func configure(with viewModel: [SearchViewModel]) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    func reloadImage(_ image: UIImage, at index: Int) {
        self.viewModel[index].image = image
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
}

// MARK: - UICollectionViewDataSource protocol

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.reuseIdentifier,
            for: indexPath
        ) as? CollectionViewCell
        else { return UICollectionViewCell() }
        let model = self.viewModel[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        self.viewModel.count
    }
}

// MARK: - UICollectionViewDelegate protocol

extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.presenter.openRecipeDetails(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeFrame = collectionView.safeAreaLayoutGuide.layoutFrame
        let size = CGSize(width: safeFrame.width, height: safeFrame.height)
        return setCollectionViewItemSize(size: size)
    }

    func setCollectionViewItemSize(size: CGSize) -> CGSize {
        let width = (size.width - 1 * Constant.cellSpacing) / 2
        return CGSize(width: width, height: width)
    }
}
