//
//  RecipeContentView.swift
//  CookRecipes
//
//  Created by Влад on 20.06.2022.
//

import UIKit

protocol IrecipeContentViewDelegate: AnyObject {
    func saveRecipe()
}

final class RecipeContentView: UIView {

    // MARK: - Constants

    private enum Constant {
        static let cardBackground = UIColor(white: 0.3, alpha: 0.5)
        static let buttonCornerRadius: CGFloat = 10
    }

    // MARK: - Constraints

    private  enum Constraint {
        static let mainTextInset = 20
    }

    // MARK: - Dependencies

    weak var delegate: IrecipeContentViewDelegate?
    var model: RecipeDetailsViewModel

    // MARK: - UI Elements

    private lazy var customView = MainCardView(model: model)
    private lazy var ingridientsView = CardsListView(array: model.ingridients, type: .ingridients)
    private lazy var instructionsView = CardsListView(array: model.instructions, type: .instructions)

    private lazy var recipeImageView = UIImageView()

    private lazy var segmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = Colors.primary50.value
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.primary50.value]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: Colors.white.value]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        segmentedControl.insertSegment(withTitle: "Ingridients", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Instructions", at: 1, animated: true)
        segmentedControl.addTarget(self, action: #selector(selectedControlChangesValue(_:)), for: .valueChanged)
        return segmentedControl
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(savedButton(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers

    init(model: RecipeDetailsViewModel, delegate: IrecipeContentViewDelegate) { // v configure
        self.delegate = delegate
        self.model = model
        super.init(frame: .zero)
    //    self.recipeNameLabel.text = model.title
        self.recipeImageView.image = model.image
        self.configureView()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") 
    }

}

// MARK: - Private

private extension RecipeContentView {

    @objc func selectedControlChangesValue(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            self.ingridientsView.isHidden = false
            self.instructionsView.isHidden = true
            instructionsView.snp.removeConstraints()
            setViewLayout(for: ingridientsView)
        } else if sender.selectedSegmentIndex == 1 {
            self.ingridientsView.isHidden = true
            self.instructionsView.isHidden = false
            ingridientsView.snp.removeConstraints()
            setViewLayout(for: instructionsView)
        }
    }

    @objc func savedButton(_ sender: UIButton) {
        delegate?.saveRecipe()
    }

    func configureView() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        self.backgroundColor = .systemBackground
        self.customView.set(model: model)
        self.customView.layer.cornerRadius = 10
        recipeImageView.layer.masksToBounds = true
        self.recipeImageView.contentMode = .scaleAspectFill
        self.segmentedControl.selectedSegmentIndex = 0
        self.customView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.customView.layer.shadowRadius = 4
        self.customView.layer.shadowOpacity = 0.25
        self.saveButton.layer.cornerRadius = 10
        self.saveButton.layer.masksToBounds = true
        self.saveButton.backgroundColor = Constant.cardBackground
    }

    // MARK: - Layout

    func setupLayout() {
        setupImageLayout()
        setupMainCardLayout()
        setupSegmentedControlLayout()
        setupCardsLayout()
    }

    func setupImageLayout() {

        if model.isLocal {
            self.saveButton.isHidden = true
        }

        self.addSubview(recipeImageView)
        self.recipeImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        self.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in

            make.top.trailing.equalToSuperview().inset(15)
            make.leading.equalTo(self.snp.trailing).inset(100)
           // make.width.equalTo(self.frame.width)
           // make.leading.equalToSuperview()
        }
    }

    func setupMainCardLayout() {
        self.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(recipeImageView.snp.bottom).inset(50)
            make.bottom.equalTo(recipeImageView.snp.bottom).offset(50)
        }
    }

    func setupSegmentedControlLayout() {
        self.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(customView.snp.bottom)
                .offset(30)
        }
    }

    func setupCardsLayout() {
        self.addSubview(ingridientsView)
        self.addSubview(instructionsView)
        ingridientsView.translatesAutoresizingMaskIntoConstraints = false
        instructionsView.translatesAutoresizingMaskIntoConstraints = false
        self.ingridientsView.isHidden = false
        self.instructionsView.isHidden = true
        setViewLayout(for: ingridientsView)
    }

    func setViewLayout(for contentView: UIView) {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
}
