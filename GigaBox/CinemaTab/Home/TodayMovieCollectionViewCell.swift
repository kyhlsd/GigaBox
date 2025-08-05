//
//  TodayMovieCollectionViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import UIKit
import SnapKit
import Kingfisher

final class TodayMovieCollectionViewCell: UICollectionViewCell, Identifying {
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = CornerRadius.small
        imageView.clipsToBounds = true
        imageView.kf.indicatorType = .activity
        imageView.tintColor = .customGreen
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = AppFonts.header
        label.textColor = .customWhite
        label.numberOfLines = 1
        return label
    }()
    
    private let favoriteButton = {
        let button = UIButton()
        button.tintColor = .customGreen
        return button
    }()
    
    private let overviewLabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.textColor = .customWhite
        label.numberOfLines = 3
        return label
    }()
    
    var movie: Movie?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewDesign()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movie = nil
        posterImageView.image = nil
        titleLabel.text = nil
        overviewLabel.text = nil
        favoriteButton.setImage(nil, for: .normal)
    }
    
    func configureData() {
        guard let movie else { return }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        if let posterPath = movie.posterPath {
            let url = URL(string: posterPath)
            posterImageView.kf.setImage(with: url, options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200 / 0.75))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
        
        setFavoriteButton(movie.id)
    }
    
    private func setFavoriteButton(_ id: Int) {
        let image = UserDefaultManager.MovieBox.getFavoriteImage(id)
        favoriteButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    @objc
    private func favoriteButtonTapped() {
        guard let id = movie?.id else { return }
        
        UserDefaultManager.MovieBox.toggleItemInMovieBox(id)
        setFavoriteButton(id)
        NotificationCenter.default.post(name: .movieBoxChanged, object: nil)
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
