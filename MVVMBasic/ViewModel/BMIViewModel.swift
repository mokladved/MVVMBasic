//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/11/25.
//

import Foundation

final class BMIViewModel {
    var inputField: (height: String?, weight: String?)? {
        didSet {
            calculate()
        }
    }
    
    var bmiResult: Observable<String?> = Observable(nil)
    var validationError: Observable<BMIValidationError?> = Observable(nil)
    
    private func calculate() {
        bmiResult.value = nil
        validationError.value = nil
        do {
            let values = try validate(height: inputField?.height, weight: inputField?.weight)
            let bmi = calculateBMI(height: values.height, weight: values.weight)
            let result = getResult(from: bmi)
            bmiResult.value = result
        } catch let error {
            validationError.value = error
        }
    }
    
    private func validate(height: String?, weight: String?) throws(BMIValidationError) -> (height: Double, weight: Double) {
        guard let heightText = height, !heightText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BMIValidationError.isEmpty(value: "키")
        }
        guard let heightValue = Double(heightText) else {
            throw BMIValidationError.notANumber(value: "키")
        }
        guard (65...289).contains(heightValue) else {
            throw BMIValidationError.notValidInput(value: "키")
        }
        
        guard let weightText = weight, !weightText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BMIValidationError.isEmpty(value: "몸무게")
        }
        guard let weightValue = Double(weightText) else {
            throw BMIValidationError.notANumber(value: "몸무게")
        }
        guard (1...635).contains(weightValue) else {
            throw BMIValidationError.notValidInput(value: "몸무게")
        }
        
        return (heightValue, weightValue)
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        let heightInMeters = height / 100
        let bmi = weight / (heightInMeters * heightInMeters)
        return bmi
    }
    
    private func getResult(from bmi: Double) -> String {
        let result = String(format: "%.1f", bmi)
        switch bmi {
        case ..<18.5:
            return "당신의 BMI 지수는 \(result)로 저체중입니다."
        case 18.5..<23:
            return "당신의 BMI 지수는 \(result)로 정상입니다."
        case 23..<25:
            return "당신의 BMI 지수는 \(result)로 과체중입니다."
        default:
            return "당신의 BMI 지수는 \(result)로 비만입니다."
        }
    }
}
