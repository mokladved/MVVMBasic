//
//  BMIValidationError.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/8/25.
//

import Foundation

enum BMIValidationError: Error {
    case isEmpty(value: String)
    case notANumber(value: String)
    case notValidInput(value: String)
    

    var description: String {
        switch self {
        case .isEmpty(let value):
            return "\(value) 입력을 해주세요."
        case .notANumber(let value):
            return "\(value)에는 숫자만 입력해 주세요."
        case .notValidInput(let value):
            return "유효한 \(value) 입력을 해주세요."
        }
    }
}
