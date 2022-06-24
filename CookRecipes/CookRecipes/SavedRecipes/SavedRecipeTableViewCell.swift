//
//  SavedRecipeTableViewCell.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import UIKit

final class SavedRecipeTableViewCell: UITableViewCell {
    
    static let tableViewReuseCellId = "SavedRecipeTableViewCell"

    // MARK: - Constant

    private enum Constant {
        static let cardColor = UIColor(white: 0.3, alpha: 0.5)
        static let cardCornerRadius: CGFloat = 5
        static let imageCornerRadius: CGFloat = 10
    }

    // MARK: - Constraint

    private enum Constraint {
        static let imageViewHeight = 180
        static let imageViewTopBottomOffset = 10
        static let imageViewLeadingTrailingInset = 20
        static let cardInset = 15

    }

    // MARK: - UI Elements


    private lazy var mainImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()

    private lazy var titleLabel = CustomLabelBuilder()
        .setFont(AppFonts.bold20.font)
        .setNumberOfLines(2)
        .setTextColor(Colors.white.value)
        .buildLabel()

    private lazy var ratingView = CustomLabelBuilder()
        .setFont(AppFonts.bold16.font)
        .setTextAlignment(.left)
        .setNumberOfLines(0)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextColor(Colors.white.value)
        .setTintColor(Colors.white.value)
        .setIcon(UIImage(systemName: "star.fill") ?? UIImage(), size: 18)
        .buildView()

    private lazy var timerView = CustomLabelBuilder()
        .setFont(AppFonts.regular14.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.white.value)
        .setNumberOfLines(0)
        .setAdjustsFontSizeToFitWidth(true)
        .setTintColor(Colors.white.value)
        .setIcon(UIImage(systemName: "clock") ?? UIImage(), size: 18)
        .buildView()

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = mainImageView.layer.cornerRadius
    }

    func configureWith(model: RecipeEntity) {
        self.titleLabel.text = model.name
        self.mainImageView.image = model.image
        timerView.textLabel.text = "\(model.minutes) min"
        ratingView.textLabel.text = model.rating
        if model.minutes > 0 {
            timerView.isHidden = false
        } else {
            timerView.isHidden = true
        }

        if model.rating != "" {
            ratingView.isHidden = false
        } else {
            ratingView.isHidden = true

        }
        configureCell()
        setupLayout()
    }
}

// MARK: - Private

private extension SavedRecipeTableViewCell {

    private func configureCell() {
        self.selectionStyle = .none
        mainImageView.layer.masksToBounds = true
        ratingView.layer.masksToBounds = true
        timerView.layer.masksToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        ratingView.layer.cornerRadius = Constant.cardCornerRadius
        timerView.layer.cornerRadius = Constant.cardCornerRadius
        mainImageView.layer.cornerRadius = Constant.imageCornerRadius
        timerView.backgroundColor = Constant.cardColor
        ratingView.backgroundColor = Constant.cardColor
        mainImageView.addGradient(with: gradientLayer)
    }

    // MARK: - Layout

    func setupLayout() {
        setupImageLayout()
        setupCardsLayout()
        setupTitleLayout()
    }

    func setupImageLayout(){
        self.contentView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.height.equalTo(Constraint.imageViewHeight)
            make.top.equalToSuperview().offset(Constraint.imageViewTopBottomOffset)

            make.leading.trailing.equalToSuperview().inset(Constraint.imageViewLeadingTrailingInset)
            make.bottom.equalToSuperview().inset(Constraint.imageViewTopBottomOffset)
        }
    }

    func setupCardsLayout() {
        self.mainImageView.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constraint.cardInset)
            make.top.equalToSuperview().offset(Constraint.cardInset)
        }
        self.mainImageView.addSubview(timerView)
        timerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constraint.cardInset)
            make.top.equalToSuperview().offset(Constraint.cardInset)
        }
    }

    func setupTitleLayout() {
        self.mainImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(Constraint.cardInset)
        }
    }
}
