//
//  EmptyWordCollectionViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/2/25.
//

import UIKit
import SnapKit

final class EmptyWordCollectionViewCell: UICollectionViewCell, Identifying {
    private let emptyLabel = {
        let label = UILabel()
        label.text = "최근 검색어 내역이 없습니다."
        label.font = AppFonts.body
        label.textColor = .customGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyWordCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(emptyLabel)
    }
    
    func configureLayout() {
        emptyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() { }
}
