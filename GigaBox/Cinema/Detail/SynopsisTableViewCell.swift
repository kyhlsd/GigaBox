//
//  SynopsisTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit

final class SynopsisTableViewCell: UITableViewCell, Identifying {

    private let titleLabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.font = AppFonts.header
        label.textColor = .customWhite
        return label
    }()
    
    private let synopsisButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.customGreen, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        return button
    }()
    
    private let synopsisLabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.textColor = .customWhite
        label.numberOfLines = 3
        return label
    }()
    
    weak var delegate: TableViewReloadRowDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        synopsisButton.addTarget(self, action: #selector(synopsisButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(text: String) {
        synopsisLabel.text = text
    }
    
    @objc
    private func synopsisButtonTapped() {
        if synopsisLabel.numberOfLines == 3 {
            synopsisLabel.numberOfLines = 0
            synopsisButton.setTitle("Hide", for: .normal)
        } else {
            synopsisLabel.numberOfLines = 3
            synopsisButton.setTitle("More", for: .normal)
        }
        delegate?.reloadRow(nil)
    }
}

extension SynopsisTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [titleLabel, synopsisButton, synopsisLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.top.equalToSuperview().inset(AppPadding.verticalPadding)
        }
        synopsisButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.lastBaseline.equalTo(titleLabel.snp.lastBaseline)
        }
        synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview().inset(AppPadding.verticalPadding)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
