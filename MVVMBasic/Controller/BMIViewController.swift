//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

final class BMIViewController: UIViewController {
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("클릭", for: .normal)
        return button
    }()
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func resultButtonTapped() {
        view.endEditing(true)
        do {
            let values = try validate(height: heightTextField.text, weight: weightTextField.text)
            let bmi = calculateBMI(height: values.height, weight: values.weight)
            let result = getResult(from: bmi)
            
            resultLabel.text = result
        } catch {
            showAlert(title: "오류", message: error.description)
        }
    }
}

extension BMIViewController {
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        configureBorder(target: resultButton, radius: 8)
        configureBackgroundColor(from: resultButton, color: .systemBlue)
        configureAlignment(for: &resultLabel, to: .center)
    }
}

extension BMIViewController {
    private func validate(height: String?, weight: String?) throws(BMIValidationError) -> (height: Double, weight: Double) {
        guard let text = height, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BMIValidationError.isEmpty(value: "키")
        }
        guard let height = Double(text) else {
            throw BMIValidationError.notANumber(value: "키")
        }
        
        guard (65...289).contains(height) else {
            throw BMIValidationError.notValidInput(value: "키")
        }
        
        guard let text = weight, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BMIValidationError.isEmpty(value: "몸무게")
        }
        
        guard let weight = Double(text) else {
            throw BMIValidationError.notANumber(value: "몸무게")
        }
        
        guard (1...635).contains(weight) else {
            throw BMIValidationError.notValidInput(value: "몸무게")
        }
        
        return (height, weight)
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        let height = height / 100
        let bmi = weight / (height * height)
        return bmi
    }
    
    private func getResult(from bmi: Double) -> String {
        let result = String(format: "%.1f", bmi)
        switch bmi {
        case ..<18.5:
            return ("당신의 BMI 지수는, \(result)로 저체중입니다")
        case 18.5..<23:
            return ("당신의 BMI 지수는, \(result)로 정상입니다.")
        case 23..<25:
            return ("당신의 BMI 지수는, \(result)로과체중입니다.")
        default:
            return ("당신의 BMI 지수는, \(result)로 비만입니다.")
        }
    }
}
