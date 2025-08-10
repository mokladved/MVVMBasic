//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/11/25.
//

import Foundation

class AgeViewModel {
    var inputField: String? {
        didSet {
            validate(inputField)
        }
    }
    
    var success: ((String) -> Void)?
    var failure: ((AgeValidationError) -> Void)?
    
    private func validate(_ text: String?) {
        guard let text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            failure?(.isEmpty)
            return
        }
        
        guard let age = Int(text) else {
            failure?(.notANumber)
            return
        }
        
        guard (1...100).contains(age) else {
            failure?(.notValidAge)
            return
        }
        
        let message = "당신은 \(age)세 입니다."
        success?(message)
    }
}
