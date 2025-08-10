//
//  BirthDayValidationError.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/8/25.
//

import Foundation

enum BirthDayValidationError: Error {
    case isEmpty(field: String)
    case notANumber(field: String)
    case notValidDate
    case failCalculate
    
    var description: String {
        switch self {
        case .isEmpty(let value):
            return "\(value) 입력을 해주세요."
        case .notANumber(let value):
            return "\(value)에는 숫자만 입력해주세요."
        case .notValidDate:
            return "유효하지 않은 날짜입니다."
        case .failCalculate:
            return "날짜 계산이 유효하지 않습니다."
        }
    }
}
