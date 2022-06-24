//
//  CategoryCollectionViewCell.swift
//  CookRecipes
//
//  Created by Влад on 22.06.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CategoryCollectionViewCell"

    // MARK: - Constants

    enum Constant {

    }

    // MARK: - Constraints

    enum Constraint {
        static let mainLabelInset = 5
    }


    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = Colors.primary50.value
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private lazy var nameLabel = CustomLabelBuilder()
        .setTextAlignment(.center)
        .setTextColor(Colors.white.value)
        .setFont(AppFonts.bold14.font)
        .buildLabel()

    func configureCell(with name: String) { 
        nameLabel.text = name
    }
}

// MARK: - Private

private extension CategoryCollectionViewCell {

    // MARK: - Layout

    func setupLayout() {
        addSubview( nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}
