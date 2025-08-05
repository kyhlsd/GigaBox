//
//  DateFormatters.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import Foundation

enum DateFormatters {
    static let yyMMddDotFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    static let yyyyMMddDotFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    static let yyyyMMddDashFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
