//
//  TodayMovieCollectionViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import UIKit
import SnapKit

final class TodayMovieCollectionViewCell: UICollectionViewCell, Identifying {
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = CornerRadius.small
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = AppFonts.header
        label.textColor = .customWhite
        label.numberOfLines = 1
        return label
    }()
    
    private let favoriteButton = UIButton()
    
    private let overviewLabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.textColor = .customWhite
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewDesign()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData() {
        
    }
    
    @objc
    private func favoriteButtonTapped() {
        
    }
}

extension TodayMovieCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [posterImageView, titleLabel, favoriteButton, overviewLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.75)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(AppPadding.verticalInset)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.size.equalTo(18)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func configureView() { }
}
