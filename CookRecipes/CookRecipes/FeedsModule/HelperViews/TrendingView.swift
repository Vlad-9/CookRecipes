//
//  TrendingView.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

protocol ITrendingViewDelegate: AnyObject {
    func openRecipeDetails(at index: Int)
}

protocol ITrendingView: UIView {
    var delegate: ITrendingViewDelegate? { get set }
    func configure(with models: [TrendingCardViewModel])
    func reloadImage(_ image: UIImage, at index: Int) 
}

class TrendingView: UIView {

    private enum Constant {
        static let cellSpacing: CGFloat = 10
    }

    //  MARK: - Dependencies

    private var trendingModels: [TrendingCardViewModel] = []
    weak var delegate: ITrendingViewDelegate?

    // MARK: - UI Elements

    private lazy var trendingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(TrendingCardCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCardCollectionViewCell.cellID)
        return collectionView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
}

// MARK: - Private

private extension TrendingView {

    // MARK: - Layout

    func setupLayout() {
        self.addSubview(trendingCollectionView)
        trendingCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - ItrendingView protocol

extension TrendingView: ITrendingView {
    func reloadImage(_ image: UIImage, at index: Int) {

        self.trendingModels[index].image = image
        trendingCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }

    func configure(with models: [TrendingCardViewModel]) {
        trendingModels = models
        trendingCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol

extension TrendingView: UICollectionViewDelegateFlowLayout {

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

        let safeFrame = collectionView.safeAreaLayoutGuide.layoutFrame
        let size = CGSize(width: safeFrame.width/1.3, height: safeFrame.height)
        return size
    }
}

// MARK: - UICollectionViewDataSource protocol

extension TrendingView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendingCardCollectionViewCell.cellID,
            for: indexPath as IndexPath
        ) as? TrendingCardCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(with: self.trendingModels[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.trendingModels.count
    }
}

// MARK: - UICollectionViewDelegate protocol

extension TrendingView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate.self?.openRecipeDetails(at: indexPath.row)
    }
}
