//
//  CollectionViewCell.swift
//  CookRecipes
//
//  Created by Влад on 17.06.2022.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constant {
        static let alphaLevelForLabelBackground = 0.7
        static let labelCornerRadius: CGFloat = 5
        static let imageCornerRadius: CGFloat = 10

        static let cardBackground = UIColor(white: 0.3, alpha: 0.5)
    }

    // MARK: - Constraints

    private enum Constraint {
        static let mainLabelInset = 5
        static let mainImageViewInset = 5

    }

    // MARK: - UI Elements

    private lazy var imageView = UIImageView()
    private lazy var gradientLayer = CAGradientLayer()

    private lazy var nameLabel = CustomLabelBuilder()
        .setTextAlignment(.left)
        .setTextColor(Colors.white.value)
        .setFont(AppFonts.bold14.font)
        .setNumberOfLines(3)
        .buildLabel()

    private lazy var authorLabel = CustomLabelBuilder()
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral40.value)
        .setFont(AppFonts.regular12.font)
        .buildLabel()

    private lazy var ratingView = CustomLabelBuilder()
        .setFont(AppFonts.bold14.font)
        .setTextAlignment(.left)
        .setNumberOfLines(0)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextColor(Colors.white.value)
        .setTintColor(Colors.white.value)
        .setIcon(UIImage(systemName: "star.fill") ?? UIImage(), size: 18)
        .buildView()

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = imageView.layer.cornerRadius
    }

    func configureCell(with model: SearchViewModel) {
        imageView.image = model.image
        nameLabel.text = model.title
        authorLabel.text = model.author
        ratingView.textLabel.text = model.rating
        if model.rating != "" {
            ratingView.isHidden = false
        } else {
            ratingView.isHidden = true

        }
        configure()
        setupLayout()
    }
}

// MARK: - Private

private extension CollectionViewCell {
    
    func configure() {
        imageView.layer.cornerRadius = Constant.imageCornerRadius
        ratingView.layer.cornerRadius = Constant.labelCornerRadius
        ratingView.backgroundColor = Constant.cardBackground
        backgroundColor = .systemBackground
        imageView.layer.masksToBounds = true
        ratingView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGradient(with: gradientLayer)
    }

    func setupLayout() {
        addImageViewLayout()
        addRatingViewLayout()
        addLabelsLayout()
    }

    func addImageViewLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constraint.mainImageViewInset)
        }
    }

    func addRatingViewLayout() {
        imageView.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(Constraint.mainLabelInset)
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-8)
        }
    }

    func addLabelsLayout() {
        imageView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(10)
            //make.trailing.equalToSuperview().inset(85)
        }
        imageView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            //   make.top.equalToSuperview().offset(90)
            make.bottom.equalToSuperview().inset(25)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
