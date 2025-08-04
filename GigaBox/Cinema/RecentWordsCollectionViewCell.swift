//
//  RecentWordsTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

final class RecentWordsCollectionViewCell: UITableViewCell, Identifying {

    private let titleLabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.font = AppFonts.header
        label.textColor = .customWhite
        return label
    }()
    
    private let deleteButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.customGreen, for: .normal)
        return button
    }()

    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = AppPadding.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: AppPadding.horizontalPadding, bottom: 0, right: AppPadding.horizontalPadding)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: WordCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: EmptyWordCollectionViewCell.self)
        return collectionView
    }()
    
//    private let tempList = ["현빈", "스파이더", "해리포터", "소방관", "크리스마스"]
    private let tempList = [String]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func deleteButtonTapped() {
        print(#function)
    }
}

extension RecentWordsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempList.isEmpty ? 1 : tempList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tempList.isEmpty {
            return collectionView.dequeueReusableCell(cellType: EmptyWordCollectionViewCell.self, for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(cellType: WordCollectionViewCell.self, for: indexPath)
            cell.configureData(tempList[indexPath.item])
            return cell
        }
    }
}

extension RecentWordsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tempList.isEmpty {
            return contentView.frame.size
        } else {
            return CGSize(width: 100, height: 32)
        }
    }
}

extension RecentWordsCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [titleLabel, deleteButton, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.top.equalToSuperview().inset(AppPadding.verticalPadding)
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.lastBaseline.equalTo(titleLabel.snp.lastBaseline)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(36)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
