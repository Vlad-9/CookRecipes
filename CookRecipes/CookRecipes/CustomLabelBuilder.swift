//
//  LabelWithIcon.swift
//  CookRecipes
//
//  Created by Влад on 20.06.2022.
//

import Foundation
import UIKit
final class CustomView: UIView {

     var imageView = UIImageView()
    private var size: Int
        var textLabel = UILabel()
    init(imageView: UIImageView,size: Int, textLabel: UILabel) {
        self.size = size
        self.imageView = imageView
        self.textLabel = textLabel
        super.init(frame: .zero)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(self.size)
            make.leading.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview().inset(2)

        }

        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(5)

        }
    }
}
final class CustomLabelBuilder {

    // MARK: - Private
     var label: UILabel
    private var view: UIView
    private var imageView: UIImageView
    private var size: Int

    // MARK: - Initializer
    init() {
        label = UILabel()
        view = UIView()
        imageView = UIImageView()
        imageView.image = nil
        size = 0
    }
    func setTintColor(_ color: UIColor) -> CustomLabelBuilder {
        imageView.tintColor = color
        return self
    }
    func setTextColor(_ color: UIColor) -> CustomLabelBuilder {
        label.textColor = color
        return self
    }

    func setFont(_ font: UIFont?) -> CustomLabelBuilder {
        label.font = font
        return self
    }

    func setTextAlignment(_ alignment: NSTextAlignment) -> CustomLabelBuilder {
        label.textAlignment = alignment
        return self
    }

    func setNumberOfLines(_ number: Int) -> CustomLabelBuilder {
        label.numberOfLines = number
        return self
    }

    func setAdjustsFontSizeToFitWidth(_ option: Bool) -> CustomLabelBuilder {
        label.adjustsFontSizeToFitWidth = option
        return self
    }

    func setIcon(_ image: UIImage, size: Int) -> CustomLabelBuilder {
        self.imageView.image = image
        self.size = size
        return self
    }

    func setText(_ string: String) -> CustomLabelBuilder {
        self.label.text = string
        return self
    }
    func changeText(_ string: String) -> CustomLabelBuilder {
        self.label.text = string
        return self
    }
    func buildLabel() -> UILabel {
        return label
    }
    func buildView() -> CustomView {
        return CustomView(imageView: self.imageView, size: self.size, textLabel: self.label)
    }
    func buildO() -> UIView {
        //        return label
        //        view.ad
        //        if self.imageView != nil {
        //            self.view.addSubview(self.imageView)
        //            imageView?.snp.makeConstraints { make in
        //            make.height.width.equalTo(self.size)
        //                make.leading.top.bottom.equalToSuperview()
        ////                make.leading.trailing..equalTo(self.safeAreaLayoutGuide).inset(Constraint.mainTextInset)
        ////            //    make.top.equalTo(closeButton.snp.bottom).offset(Constraint.textTopOffset)
        ////                make.bottom.lessThanOrEqualToSuperview().inset(Constraint.mainTextInset)
        //            }
        //
        //        self.view.addSubview(label)
        //        label.snp.makeConstraints { make in
        //                make.trailing.top.bottom.equalToSuperview()
        //            make.leading.equalTo(imageView?.snp.trailing).offset(5)
        //    //                make.leading.trailing..equalTo(self.safeAreaLayoutGuide).inset(Constraint.mainTextInset)
        //    //            //    make.top.equalTo(closeButton.snp.bottom).offset(Constraint.textTopOffset)
        //    //                make.bottom.lessThanOrEqualToSuperview().inset(Constraint.mainTextInset)
        //                }
        if imageView.image != nil {
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.height.width.equalTo(self.size)
                make.leading.equalToSuperview().inset(5)
                make.top.bottom.equalToSuperview().inset(2)

            }

            self.view.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(2)
                make.trailing.equalToSuperview().inset(5)
                make.leading.equalTo(imageView.snp.trailing).offset(5)

            }
        } else {
            self.view.addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

        }
        return view
    }
}
