//
//  AdditionalCardView.swift
//  CookRecipes
//
//  Created by Влад on 20.06.2022.
//

import UIKit

protocol IAdditionalCardView: AnyObject {
    func set(text: String, icon: UIImage)// configure with
}

final class AdditionalCardView: UIView {

    // MARK: - Constants

    private enum Constant {
        static let cardCornerRadius: CGFloat = 10
        // static let buttonTitle = "Close"
    }

    // MARK: - Constraints

    private  enum Constraint {
        static let mainTextInset = 20
        static let closeButtonTopOffset = 8
        static let textTopOffset = 5
    }

    // MARK: - Dependencies

    var type: CardType

    // MARK: - UI Elements

    private lazy var textLabel = CustomLabelBuilder()
        .setNumberOfLines(0)
        .setFont(AppFonts.regular12.font)
        .setTextColor(Colors.neutral90.value)
        .buildLabel()
    
    private lazy var numberLabel = CustomLabelBuilder()
        .setNumberOfLines(1)
        .setFont(AppFonts.bold32.font)
        .buildLabel()

    private lazy var iconImageView = UIImageView()
    private lazy var checkboxButton: UIButton = {
        var checkbox = UIButton.init(type: .custom)
        checkbox.setImage(UIImage.init(named: "checkmark"), for: .normal)
        checkbox.setImage(UIImage.init(named: "checkmarkfilled"), for: .selected)
        checkbox.addTarget(self, action: #selector(self.toggleCheckboxSelection), for: .touchUpInside)
        return checkbox
    }()

    // MARK: - Initializers

    init(model: AdditionalCardViewModel) {
        self.type = model.type
        super.init(frame: .zero)

        switch type {
        case .instructions:
            self.textLabel.text = model.text
            self.numberLabel.text = model.number
            self.checkboxButton.isHidden = true
        case .ingridients: 
            self.textLabel.text = model.text
            self.checkboxButton.isHidden = false
        }
        self.configureView()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension AdditionalCardView {
    
    @objc func toggleCheckboxSelection() {
        checkboxButton.isSelected = !checkboxButton.isSelected
    }

    func configureView() {
        self.backgroundColor = Colors.neutral10.value //.systemGray6
        self.layer.cornerRadius = Constant.cardCornerRadius
    }

    // MARK: - Layout

    func setupLayout() {

        switch type {
        case .instructions:
            setupInstructionsLayout()
        case .ingridients:
            setupIngridientsLayout()
        }
    }

    func setupIngridientsLayout() {
        self.addSubview(checkboxButton)
        checkboxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }

        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.trailing.equalTo(checkboxButton.snp.leading).offset(-30)
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }

    }

    func setupInstructionsLayout() {
        self.numberLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.addSubview(numberLabel)

        numberLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(15)
            make.trailing.lessThanOrEqualToSuperview().inset(290)
        }
        self.textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalTo(self.snp.leading).offset(60)
            make.centerY.equalTo(numberLabel)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
