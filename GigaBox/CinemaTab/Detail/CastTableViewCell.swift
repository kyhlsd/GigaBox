//
//  CastTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit

final class CastTableViewCell: UITableViewCell, Identifying {
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = AppFonts.header
        label.textColor = .customWhite
        return label
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.backgroundColor = .clear
        tableView.register(cellType: ActorInfoTableViewCell.self)
        return tableView
    }()
    
    private var casts: [ActorInfo] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(casts: [ActorInfo]) {
        self.casts = casts
        tableView.reloadData()
    }
}

extension CastTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: ActorInfoTableViewCell.self, for: indexPath)
        cell.configureData(actorInfo: casts[indexPath.row])
        return cell
    }
}

extension CastTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [titleLabel, tableView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.top.equalToSuperview().inset(AppPadding.verticalPadding)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview().inset(AppPadding.verticalPadding)
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
