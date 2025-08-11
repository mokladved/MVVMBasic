//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/11/25.
//

import Foundation

final class AgeViewModel {
    var inputField: String? {
        didSet {
            validate(inputField)
        }
    }
    
    var success: Observable<String?> = Observable(nil)
    var failure : Observable<AgeValidationError?> = Observable(nil)
    
    private func validate(_ text: String?) {
        success.value = nil
        failure.value = nil
        guard let text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            failure.value = .isEmpty
            return
        }
        
        guard let age = Int(text) else {
            failure.value = .notANumber
            return
        }
        
        guard (1...100).contains(age) else {
            failure.value = .notValidAge
            return
        }
        
        let message = "당신은 \(age)세 입니다."
        success.value = message
    }
}
