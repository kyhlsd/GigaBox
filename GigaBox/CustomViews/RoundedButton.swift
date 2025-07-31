//
//  RoundedButton.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit

class RoundedButton: UIButton {
    
    private let title: String
    private let color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
        
        super.init(frame: .zero)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
    }
    
    private func configure() {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = .clear
        layer.borderColor = color.cgColor
        layer.borderWidth = 1.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
