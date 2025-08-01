//
//  ViewDesignProtocol.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import Foundation

protocol ViewDesignProtocol: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}

extension ViewDesignProtocol {
    func configureViewDesign() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
}
