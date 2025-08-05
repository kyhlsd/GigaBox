//
//  EmptySearchedTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit

final class EmptySearchedTableViewCell: UITableViewCell, Identifying {

    private let label = {
        let label = UILabel()
        label.text = "원하는 검색 결과를 찾지 못했습니다."
        label.textColor = .customGray
        label.font = AppFonts.body
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptySearchedTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(label)
    }
    
    func configureLayout() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
