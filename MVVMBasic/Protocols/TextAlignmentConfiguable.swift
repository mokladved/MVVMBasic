//
//  TextAlignmentConfiguable.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/7/25.
//

import UIKit

protocol TextAlignmentConfiguable {
    var textAlignment: NSTextAlignment { get set }
}

func configureAlignment<T>(for view: inout T, to alignment: NSTextAlignment) where T: UIView, T: TextAlignmentConfiguable {
    view.textAlignment = alignment
}
