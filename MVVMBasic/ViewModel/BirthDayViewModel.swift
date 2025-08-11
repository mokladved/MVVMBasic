//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by Youngjun Kim on 8/11/25.
//

import Foundation

final class BirthDayViewModel {
    var dDayResult: Observable<String?> = Observable(nil)
    var validationError: Observable<BirthDayValidationError?> = Observable(nil)
    
    var inputField: (year: String?, month: String?, day: String?)? {
        didSet {
            calculateDDay()
        }
    }
    
    
    private func calculateDDay() {
        dDayResult.value = nil
        validationError.value = nil
        do {
            let birthDate = try validate(year: inputField?.year, month: inputField?.month, day: inputField?.day)
            if let dDay = calculateDDays(from: birthDate) {
                let message = "오늘 날짜를 기준으로 D+\(dDay) 입니다."
                dDayResult.value = message
            }
        } catch let error {
            validationError.value = error
        }
    }

    private func validate(year: String?, month: String?, day: String?) throws(BirthDayValidationError) -> Date {
        guard let yearText = year, !yearText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BirthDayValidationError.isEmpty(field: "년")
        }
        
        guard let monthText = month, !monthText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BirthDayValidationError.isEmpty(field: "월")
        }
        
        guard let dayText = day, !dayText.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BirthDayValidationError.isEmpty(field: "일")
        }
        
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
        let pastDay = calendar.startOfDay(for: past)
        
        let result = calendar.dateComponents([.day], from: pastDay, to: today)
        return result.day
    }
}
