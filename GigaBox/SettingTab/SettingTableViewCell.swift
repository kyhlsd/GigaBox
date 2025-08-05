//
//  SettingTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell, Identifying {

    private let label = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = AppFonts.body
        return label
    }()
    
    private let underlineView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(text: String) {
        label.text = text
    }
}

extension SettingTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [label, underlineView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.height.equalTo(52)
        }
        
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.bottom.equalTo(label)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
