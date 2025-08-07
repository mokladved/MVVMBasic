//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/7/25.
//

import UIKit

extension UIViewController {
    func configureBorder<T: UIView>(
        target view: T,
        radius: CGFloat,
        width: CGFloat = 0,
        color: UIColor? = nil,
    )
    {
        view.layer.cornerRadius = radius
        view.layer.borderWidth = width
        view.layer.borderColor = color?.cgColor
        view.layer.masksToBounds = true
    }
    
    func configureBackgroundColor<T: UIView> (from view: T, color: UIColor) {
        view.backgroundColor = color
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
