//
//  UIView+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import UIKit

extension UIView {
    func setupViewBorder(cornerRadius: CGFloat?, borderWidth: CGFloat?, masksToBound: Bool?) {
        self.layer.cornerRadius = cornerRadius ?? CGFloat()
        self.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        self.layer.borderWidth = borderWidth ?? CGFloat()
        self.layer.masksToBounds = masksToBound ?? Bool()
    }
}
