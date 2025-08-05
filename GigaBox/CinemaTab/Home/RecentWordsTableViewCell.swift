//
//  RecentWordsTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

protocol DeleteRecentWordProtocol: AnyObject {
    func deleteWord(_ text: String)
}

final class RecentWordsTableViewCell: UITableViewCell, Identifying {

    private let titleLabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.font = AppFonts.header
        label.textColor = .customWhite
        return label
    }()
    
    private let clearButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.customGreen, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        return button
    }()

    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = AppPadding.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: AppPadding.horizontalPadding, bottom: 0, right: AppPadding.horizontalPadding)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: WordCollectionViewCell.self)
        collectionView.register(cellType: EmptyWordCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var searchedWords = UserDefaultManager.SearchedWords.list
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func clearButtonTapped() {
        UserDefaultManager.SearchedWords.clear()
        searchedWords = UserDefaultManager.SearchedWords.list
        collectionView.reloadData()
    }
}

extension RecentWordsTableViewCell: DeleteRecentWordProtocol {
    func deleteWord(_ text: String) {
        UserDefaultManager.SearchedWords.deleteWord(text: text)
        searchedWords = UserDefaultManager.SearchedWords.list
        collectionView.reloadData()
    }
}

extension RecentWordsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchedWords.isEmpty {
            collectionView.isScrollEnabled = false
            return 1
        } else {
            collectionView.isScrollEnabled = true
            return searchedWords.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchedWords.isEmpty {
            return collectionView.dequeueReusableCell(cellType: EmptyWordCollectionViewCell.self, for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(cellType: WordCollectionViewCell.self, for: indexPath)
            cell.delegate = self
            cell.configureData(searchedWords[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: View 연결, 순서 바꾸기
        if !searchedWords.isEmpty {
            print(searchedWords[indexPath.item])
        }
    }
}

extension RecentWordsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if searchedWords.isEmpty {
            return contentView.frame.size
        } else {
            return CGSize(width: 100, height: 32)
        }
    }
}

extension RecentWordsTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [titleLabel, clearButton, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.top.equalToSuperview().inset(AppPadding.verticalPadding)
        }
        clearButton.snp.makeConstraints { make in
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
