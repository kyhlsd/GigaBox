//
//  WordCollectionViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

final class WordCollectionViewCell: UICollectionViewCell, Identifying {
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        view.clipsToBounds = true
        return view
    }()
    
    private let wordLabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = AppFonts.body
        label.textAlignment = .center
        return label
    }()
    
    private let xmarkButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .customBlack
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewDesign()
        xmarkButton.addTarget(self, action: #selector(xmarkButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }
    
    func configureData(_ word: String) {
        wordLabel.text = word
    }
    
    @objc
    private func xmarkButtonTapped() {
        print(#function)
    }
}

extension WordCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [wordLabel, xmarkButton].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(AppPadding.horizontalInset)
            make.size.equalTo(16)
        }
        
        wordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(AppPadding.horizontalInset)
            make.trailing.equalTo(xmarkButton.snp.leading).inset(AppPadding.horizontalInset)
        }
    }
    
    func configureView() {}
}
