//
//  UIView+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import UIKit

extension UIView {
    func setupViewBorder(cornerRadius: CGFloat, borderWidth: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        self.layer.borderWidth = borderWidth
    }
}
