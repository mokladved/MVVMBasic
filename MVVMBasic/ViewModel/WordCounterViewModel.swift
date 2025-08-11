//
//  WordCounterVIewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/10/25.
//

import Foundation

final class WordCounterViewModel {
    var inputField = "" {
        didSet {
            countText()
        }
    }
    
    var textUpdated = Observable("현재까지 0글자 작성중")

    private func countText() {
        let count = inputField.count
        textUpdated.value = "현재까지 \(count)글자 작성중"
    }
}
