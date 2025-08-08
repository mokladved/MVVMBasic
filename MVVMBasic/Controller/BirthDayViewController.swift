//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

final class BirthDayViewController: UIViewController {
    private let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    private let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    private let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    private let resultButton: UIButton = {
        let button = UIButton()
        button.setTitle( "클릭", for: .normal)
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
            let birthDate = try validate(year: yearTextField.text, month: monthTextField.text, day: dayTextField.text)
            if let dDay = calculateDDays(from: birthDate) {
                resultLabel.text = "오늘 날짜를 기준으로 D+\(dDay) 입니다."
            } else {
                showAlert(title: "계산 오류", message: "날짜 계산이 유효하지 않습니다.")
            }
        } catch {
            showAlert(title: "오류", message: error.description)
        }
    }
}

extension BirthDayViewController: UIConfiguable {
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
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

// TODO: 다른 유효한 날짜 검증 방법 찾기
extension BirthDayViewController {
    private func validate(year: String?, month: String?, day: String?) throws(BirthDayValidationError) -> Date {
        guard let yearText = year, !yearText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BirthDayValidationError.isEmpty(field: "년")
        }
        
        guard let monthText = month, !monthText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BirthDayValidationError.isEmpty(field: "월")
        }
        
        guard let dayText = day, !dayText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BirthDayValidationError.isEmpty(field: "일") }
        
        guard let year = Int(yearText) else {
            throw BirthDayValidationError.notANumber(field: "년")
        }
        
        guard let month = Int(monthText) else {
            throw BirthDayValidationError.notANumber(field: "월")
        }
        
        guard let day = Int(dayText) else {
            throw BirthDayValidationError.notANumber(field: "일")
        }
        
        let formattedMonth = String(format: "%02d", month)
        let formattedDay = String(format: "%02d", day)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.isLenient = false
        
        let dateString = "\(year)\(formattedMonth)\(formattedDay)"
        
        if let date = formatter.date(from: dateString) {
            return date
        }
        throw BirthDayValidationError.notValidDate
    }
    
    private func calculateDDays(from past: Date) -> Int? {
        let calendar = Calendar.current
        
        let now = Date()
        let today = calendar.startOfDay(for: now)
        let past = calendar.startOfDay(for: past)
        
        let result = calendar.dateComponents([.day], from: past, to: today)
        return result.day
    }
}
