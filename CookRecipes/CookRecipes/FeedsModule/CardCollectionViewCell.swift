//
//  CardCollectionViewCell.swift
//  CookRecipes
//
//  Created by Влад on 22.06.2022.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {

    static let cellID = "CardCollectionViewCell"

    // MARK: - Constants

    enum Constant {
    }

    enum Constraint {
        static let mainLabelInset = 5
    }

    // MARK: - UI Elements

    var mainImageView = UIImageView()
    let gradientLayer = CAGradientLayer()

    private lazy var titleLabel = CustomLabelBuilder()
        .setFont(AppFonts.bold14.font)
        .setNumberOfLines(3)
        .setTextColor(Colors.neutral90.value)
        .setAdjustsFontSizeToFitWidth(true)
        .buildLabel()

    private lazy var caloriesLabel = CustomLabelBuilder()
        .setFont(AppFonts.regular12.font)
        .setNumberOfLines(0)
        .setTextColor(Colors.neutral40.value)
        .buildLabel()

    private lazy var timerView = CustomLabelBuilder()
        .setFont(AppFonts.regular12.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(0)
        .setAdjustsFontSizeToFitWidth(true)
        .setTintColor(Colors.neutral40.value)
        .setIcon(UIImage(systemName: "clock") ?? UIImage(), size: 14)
        .buildView()

    // MARK: - Lifecycle

    override func layoutSubviews() {
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    func configureCell(model: CategoryRecipeViewModel) {
        self.titleLabel.text = model.title
        self.mainImageView.image = model.image


        if let calories = model.calories  {
            caloriesLabel.text = "\(calories) kcal"
        }
        if let time = model.time  {
            timerView.isHidden = false
            //imerView = timerLabel.setText("\(time) min").build()
            self.timerView.textLabel.text =  "\(time) min"
        } else {
           // timerView = timerLabel.setText("").build()
            self.timerView.textLabel.text =  ""
            timerView.isHidden = true
        }
        configureCell()
        setupLayout()
    }
}

// MARK: - Private

private extension CardCollectionViewCell {

    private func configureCell() {
        mainImageView.layer.masksToBounds = true
        timerView.layer.masksToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        backgroundColor = .systemBackground
    }

    // MARK: Layout

    func setupLayout() {
        setupImageViewLayout()
        setupTitleLabelLayout()
        setupTimerViewLayout()
        setupCaloriesLabelLayout()
    }

    func setupImageViewLayout() {
        self.contentView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(self.frame.height/2) //todo поменять на height вместои нсета
        }
    }

    func setupTitleLabelLayout() {
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }

    func setupTimerViewLayout() {
        self.contentView.addSubview(timerView)
        timerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    func setupCaloriesLabelLayout() {
        self.contentView.addSubview(caloriesLabel)
        caloriesLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(timerView)
        }
    }
}
