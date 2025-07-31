//
//  AppFonts.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import UIKit

enum AppFonts {
    static let onboarding = UIFont.systemFont(ofSize: 28).fontDescriptor.withSymbolicTraits([.traitItalic, .traitBold])
    static let title = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let header = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let body = UIFont.systemFont(ofSize: 14)
    static let detail = UIFont.systemFont(ofSize: 12)
}
