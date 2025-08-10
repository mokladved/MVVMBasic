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
    
    private var ouputText = "" {
        didSet {
            textUpdated?(ouputText)
        }
    }
    
    var textUpdated: ((String) -> Void)?

    private func countText() {
        let count = inputField.count
        ouputText = "현재까지 \(count)글자 작성중"
    }
}
