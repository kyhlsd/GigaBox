//
//  NumberFormatter.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import Foundation

enum NumberFormatters {
    static let oneDigitFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}
