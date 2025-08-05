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
    
    private var searchWords = UserDefaultManager.SearchWords.list
    weak var delegate: PushSearchVCDelegate?
    
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
    
    func configureData() {
        searchWords = UserDefaultManager.SearchWords.list
        collectionView.reloadData()
    }
    
    @objc
    private func clearButtonTapped() {
        UserDefaultManager.SearchWords.clear()
        searchWords.removeAll()
        collectionView.reloadData()
    }
}

extension RecentWordsTableViewCell: DeleteRecentWordProtocol {
    func deleteWord(_ text: String) {
        UserDefaultManager.SearchWords.deleteWord(text: text)
        searchWords = UserDefaultManager.SearchWords.list
        collectionView.reloadData()
    }
}

extension RecentWordsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchWords.isEmpty {
            collectionView.isScrollEnabled = false
            return 1
        } else {
            collectionView.isScrollEnabled = true
            return searchWords.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchWords.isEmpty {
            return collectionView.dequeueReusableCell(cellType: EmptyWordCollectionViewCell.self, for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(cellType: WordCollectionViewCell.self, for: indexPath)
            cell.delegate = self
            cell.configureData(searchWords[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchWords.isEmpty { return }
        
        let searchWord = searchWords[indexPath.item]
        UserDefaultManager.SearchWords.addWord(text: searchWord)
        delegate?.pushSearchViewController(keyword: searchWord)
    }
}

extension RecentWordsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if searchWords.isEmpty {
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
