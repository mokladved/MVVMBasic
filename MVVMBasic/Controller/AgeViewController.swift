//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

final class AgeViewController: UIViewController {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let resultButton: UIButton = {
        let button = UIButton()
        button.setTitle( "클릭", for: .normal)
        return button
    }()
    private var label: UILabel = {
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
            let age = try validate(textField.text)
            label.text = "당신은 \(age)세 입니다."
        } catch {
            switch error {
            case .isEmpty:
                showAlert(title: "오류", message: error.description)
            case .notANumber:
                showAlert(title: "오류", message: error.description)
            case .notValidAge:
                showAlert(title: "오류", message: error.description)
            }
        }
    }
}

extension AgeViewController: UIConfiguable {
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        configureBorder(target: resultButton, radius: 8)
        configureBackgroundColor(from: resultButton, color: .systemBlue)
        configureAlignment(for: &label, to: .center)
    }
}

extension AgeViewController {
    private func validate(_ text: String?) throws(AgeValidationError) -> Int {
        guard let text = text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw AgeValidationError.isEmpty
        }
        
        guard let age = Int(text) else {
            throw AgeValidationError.notANumber
        }
        
        guard (1...100).contains(age) else {
            throw AgeValidationError.notValidAge
        }
        
        return age
    }
    
}
