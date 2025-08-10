//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/10/25.
//

import Foundation

class CurrencyViewModel {
    private let exchangeRate = 1391.0
    
    var inputField: String? = "" {
        didSet {
            convert()
        }
    }
    
    
    var message = "" {
        didSet {
            outputLabel?()
        }
    }
    
    var rate = "" {
        didSet {
            outputRate?()
        }
    }
    
    var outputLabel: (() -> Void)?
    var outputRate: (() -> Void)?
    
    // TODO: API로 환율 받아와보기
    private func convert() {
        guard let amountText = inputField,
              let amount = Double(amountText) else {
            message = "올바른 금액을 입력해주세요"
            return
        }
        
        let convertedAmount = amount / exchangeRate
        message = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        
    }
}
