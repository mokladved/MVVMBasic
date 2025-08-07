//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/7/25.
//

import UIKit

extension ViewController {
    func configureBorder<T: UIView>(
        target view: T,
        radius: CGFloat,
        width: CGFloat = 1,
        color: CGColor = UIColor.black.cgColor )
    {
        view.layer.cornerRadius = radius
        view.layer.borderWidth = width
        view.layer.borderColor = color
    }
}
