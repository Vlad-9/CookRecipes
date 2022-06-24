//
//  TrendingCardCollectionViewCell.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

final class TrendingCardCollectionViewCell: UICollectionViewCell {

    static let cellID = "TrendingCardCollectionViewCell"
    // MARK: - Constant

    enum Constant {
        static let alphaLevelForLabelBackground = 0.7
        static let labelCornerRadius: CGFloat = 5
        static let mainCornerRadius: CGFloat = 10
        static let cardBackground = UIColor(white: 0.3, alpha: 0.5)
    }

    // MARK: - Constraint

    enum Constraint {
        static let imageViewBottomInset = 50
        static let ratingViewInset = 10
        static let nameLabelTopOffset = 8
        static let labelsLeadingTrailingInset = 10

    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI Elements


    private lazy var imageView = UIImageView()

    private lazy var ratingView = CustomLabelBuilder()
        .setFont(AppFonts.bold14.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(0)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextColor(Colors.white.value)
        .setTintColor(Colors.white.value)
        .setIcon(UIImage(systemName: "star.fill") ?? UIImage(), size: 16)
        .buildView()

    private lazy var nameLabel = CustomLabelBuilder()
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(2)
        .setFont(AppFonts.bold16.font)
        .buildLabel()

    private lazy var authorLabel = CustomLabelBuilder()
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral40.value)
        .setNumberOfLines(0)
        .setFont(AppFonts.regular12.font)
        .buildLabel()

    func configure(with model: TrendingCardViewModel) {
        imageView.image = model.image
        nameLabel.text = model.title
        authorLabel.text = model.author
        ratingView.textLabel.text = model.rating 
        configure()
        setupLayout()
        
        if !model.rating.isEmpty {
            self.ratingView.isHidden = false
        } else {
            self.ratingView.isHidden = true
        }
    }
}

// MARK: - Private

private extension TrendingCardCollectionViewCell {

    func configure() {
        imageView.layer.cornerRadius = Constant.mainCornerRadius
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        ratingView.layer.masksToBounds = true
        ratingView.layer.cornerRadius = Constant.mainCornerRadius
        ratingView.backgroundColor = Constant.cardBackground
    }

    // MARK: - Layout

    func setupLayout() {
        setupImage()
        setupRatingView()
        setupLabels()
    }

    func setupImage() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
                .inset(Constraint.imageViewBottomInset)
        }
    }

    func setupRatingView() {
        imageView.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
                .inset(Constraint.ratingViewInset)
        }
    }

    func setupLabels() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
                .offset(Constraint.nameLabelTopOffset)
            make.leading.trailing.equalToSuperview()
                .inset(Constraint.labelsLeadingTrailingInset)
        }
        addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
                .inset(Constraint.labelsLeadingTrailingInset)
            make.top.equalTo(nameLabel.snp.bottom)
        }
    }
}
