//
//  TextValidateHelper.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import Foundation

enum NonValidTextError: Error {
    case invalidLength(min: Int, max: Int)
    case containsSpecialChar(chars: [Character])
    case containsNumber
    case unknown
    
    var errorMessage: String {
        switch self {
        case .invalidLength(let min, let max):
            return "\(min)글자 이상 \(max + 1) 미만으로 설정해주세요."
        case .containsSpecialChar(let chars):
            var resultString = chars.reduce("") { $0 + "\($1), " }
            resultString.removeLast(2)
            return "\(resultString) 는 사용할 수 없습니다."
        case .containsNumber:
            return "숫자는 사용할 수 없습니다."
        case .unknown:
            return "알 수 없는 에러가 발생했습니다."
        }
    }
}

enum TextValidateHelper {
    
    static func validateLength(_ text: String?, min: Int, max: Int) throws {
        let text = text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if text.count < min || text.count > max {
            throw NonValidTextError.invalidLength(min: min, max: max)
        }
    }
    
    static func validateSpecialChar(_ text: String?, specialChars: [Character]) throws {
        guard let text else { return }
        
        for specialChar in specialChars {
            if text.contains(specialChar) {
                throw NonValidTextError.containsSpecialChar(chars: specialChars)
            }
        }
    }
    
    static func validateNumber(_ text: String?) throws {
        guard let text else { return }
        
        if let _ = text.rangeOfCharacter(from: CharacterSet.decimalDigits) {
            throw NonValidTextError.containsNumber
        }
    }
}


