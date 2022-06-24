//
//  MainCardView.swift
//  CookRecipes
//
//  Created by Влад on 20.06.2022.
//

import UIKit

protocol IMainCardView: AnyObject {

    func set(model: RecipeDetailsViewModel)
}

final class MainCardView: UIView {

    // MARK: - Constant

    private enum Constant {
        static let buttonCornerRadius: CGFloat = 10
      //  static let buttonTitle = ""
    }

    // MARK: - Constraint

    private  enum Constraint {
        static let mainTextInset = 20
        static let closeButtonTopOffset = 8
        static let textTopOffset = 5
    }

    // MARK: - Dependencies

    var model: RecipeDetailsViewModel

    // MARK: - UI Elements

    private lazy var textLabel = CustomLabelBuilder()
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setFont(AppFonts.bold32.font)
        .buildLabel()

    private lazy var ratingView = CustomLabelBuilder()
        .setFont(AppFonts.bold16.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.rating100.value)
        .setNumberOfLines(0)
        .setAdjustsFontSizeToFitWidth(true)
        .setIcon(UIImage(systemName: "star.fill") ?? UIImage(), size: 18)
        .setText("\(model.rating)")
        .setTintColor(Colors.rating100.value)
        .buildView()

    private lazy var timerView = CustomLabelBuilder()
        .setFont(AppFonts.regular12.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral90.value)
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setIcon(UIImage(systemName: "clock") ?? UIImage(), size: 16)
        .setText("\(model.minutes) min")
        .setTintColor(Colors.neutral40.value)
        .buildView()

    private lazy var infoLabel = CustomLabelBuilder()
        .setFont(AppFonts.regular12.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral40.value)
        .setNumberOfLines(1)
        .setTintColor(Colors.neutral40.value)
        .setAdjustsFontSizeToFitWidth(true)
      //  .setIcon(UIImage(named: "dish") ?? UIImage(), size: 17)
        .setText("\(model.calories) kcal , \(model.servings) servings")
        .buildLabel()

    private lazy var authorView = CustomLabelBuilder()
        .setFont(AppFonts.regular12.font)
        .setTextAlignment(.left)
        .setTextColor(Colors.neutral40.value)
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setText("By \(model.author)")
        .buildView()

    // MARK: - Initializers

    init(model: RecipeDetailsViewModel) {
        self.model = model
        super.init(frame: .zero)
        self.configureView()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IMainWidgetView protocol

extension MainCardView: IMainCardView {

    func set(model: RecipeDetailsViewModel) {
        self.textLabel.text = model.title
        self.model = model
    }
}

// MARK: - Private

private extension MainCardView {

    func configureView() {
        self.backgroundColor = .systemBackground
    }

    // MARK: - Layout

    func setupLayout() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        self.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(6)
        }
        if model.minutes > 0 {
            self.addSubview(timerView)
            timerView.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview().inset(6)
            }
        }

        self.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(6)
        }

        if !model.author.isEmpty {
            self.addSubview(authorView)
            authorView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(6)
                make.centerY.equalTo(infoLabel)
            }
        }
    }
}
