//
//  SearchedMovieTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchedMovieTableViewCell: UITableViewCell, Identifying {
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = CornerRadius.medium
        imageView.clipsToBounds = true
        imageView.tintColor = .customGreen
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = AppFonts.header
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.textColor = .customGray
        label.font = AppFonts.body
        return label
    }()
    
    private let genreStackView = {
        let stackView = UIStackView()
        stackView.spacing = AppPadding.horizontalInset
        return stackView
    }()
    
    private let favoriteButton = {
        let button = UIButton()
        button.tintColor = .customGreen
        return button
    }()
    
    private var id: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        dateLabel.text = nil
        id = nil
        genreStackView.arrangedSubviews.forEach { view in
            genreStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func configureData(movie: Movie) {
        self.id = movie.id
        
        if let posterPath = movie.posterPath {
            let url = URL(string: posterPath)
            posterImageView.kf.setImage(with: url, options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 60, height: 100))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
        
        titleLabel.text = movie.title
        if let date = DateFormatters.yyyyMMddDashFormatter.date(from: movie.releaseDate) {
            dateLabel.text = DateFormatters.yyyyMMddDotFormatter.string(from: date)
        }
        
        setFavoriteButton(movie.id)
        
        movie.representativeGenre.forEach { genre in
            let label = InsetLabel()
            label.text = genre.name
            label.textColor = .customWhite
            label.font = AppFonts.detail
            label.backgroundColor = .customGray
            label.layer.cornerRadius = 4
            label.clipsToBounds = true
            genreStackView.addArrangedSubview(label)
        }
    }
    
    private func setFavoriteButton(_ id: Int) {
        let image = UserDefaultManager.MovieBox.getFavoriteImage(id)
        favoriteButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    @objc
    private func favoriteButtonTapped() {
        guard let id else { return }
        
        UserDefaultManager.MovieBox.toggleItemInMovieBox(id)
        setFavoriteButton(id)
    }
}

extension SearchedMovieTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [posterImageView, titleLabel, dateLabel, genreStackView, favoriteButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(AppPadding.verticalInset)
            make.leading.equalToSuperview().offset(AppPadding.horizontalPadding)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.75)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppPadding.verticalInset)
            make.leading.equalTo(posterImageView.snp.trailing).offset(AppPadding.horizontalInset)
            make.trailing.equalToSuperview().inset(AppPadding.horizontalPadding)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(AppPadding.verticalInset)
            make.trailing.equalTo(titleLabel)
            make.size.equalTo(18)
        }
        
        genreStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(AppPadding.verticalInset)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(favoriteButton.snp.leading)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
