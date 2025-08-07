//
//  AgeVaildationError.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/8/25.
//

import Foundation

enum AgeValidationError: Error {
    case notValidAge
    case notANumber
    case isEmpty
    
    var description: String {
        switch self {
        case .notValidAge:
            return "1부터 100까지 숫자를 입력해 주세요"
        case .notANumber:
            return "숫자를 입력해 주세요."
        case .isEmpty:
            return "공백은 허용하지 않아요."
        }
    }
}
