//
//  CardsListView.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import UIKit

enum CardType {
    case ingridients
    case instructions
}

final class CardsListView: UIView {

    // MARK: - Constants

    private  enum Constant {
        static let IngridientsTitle = "Ingridients"
        static let InstructionsTitle = "Instructions"
        static let IngridientsSubTitle = "Prepare the ingridients before start cooking"
        static let InstructionsSubTitle = "Follow these steps to cook this recipe"
    }
    // MARK: - Constraints

    private  enum Constraint {
        static let cardsTopOffset = 10
    }

    // MARK: - Dependencies

    private var modelArray: [String]
    private var type: CardType
    private lazy var cardViewArray: [AdditionalCardView] = []

    // MARK: - UI Elements

    private lazy var titleLabel = CustomLabelBuilder()
        .setNumberOfLines(0)
        .setFont(AppFonts.bold20.font)
        .buildLabel()

    private lazy var subTitleLabel = CustomLabelBuilder()
    .setNumberOfLines(0)
    .setFont(AppFonts.regular12.font)
    .buildLabel()

    // MARK: - Initializers

    init(array: [String], type: CardType) {
        self.modelArray = array
        self.type = type
        super.init(frame: .zero)
        self.configure()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension CardsListView {

    func configure() {

        switch type {
        case .instructions:
            self.titleLabel.text = Constant.InstructionsTitle
            self.subTitleLabel.text = Constant.InstructionsSubTitle
        case .ingridients:
            self.titleLabel.text = Constant.IngridientsTitle
            self.subTitleLabel.text = Constant.IngridientsSubTitle
        }

        for (index, element) in modelArray.enumerated() {
            let model = AdditionalCardViewModel(text: element,
                                                number: "\(index + 1)",
                                                type: type)
            let view = AdditionalCardView(model: model)
            cardViewArray.append(view)
        }
    }

    // MARK: - Layout

    func setupLayout() {
        setupTitleLayout()
        setupCardsLayout()
    }

    func setupTitleLayout() {

        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview() // .offset(5)
            make.leading.trailing.equalToSuperview()//.inset(20)
        }

        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()//.inset(20)
        }
    }

    func setupCardsLayout() {
        for  index in 0..<cardViewArray.count {
            cardViewArray[index].translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(cardViewArray[index])
            if index == 0 {
                cardViewArray[index].snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()

                    make.top.equalTo(subTitleLabel.snp.bottom).offset(10)
                }
            } else if index == cardViewArray.count-1 {
                cardViewArray[index].snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()

                    make.top.equalTo(cardViewArray[index-1].snp.bottom)
                        .offset(Constraint.cardsTopOffset)
                    make.bottom.equalToSuperview()
                }
            } else {
                cardViewArray[index].snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()

                    make.top.equalTo(cardViewArray[index-1].snp.bottom)
                        .offset(Constraint.cardsTopOffset)
                }
            }
        }
    }
}
