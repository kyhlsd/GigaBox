//
//  MovieInfoTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import UIKit

final class MovieInfoTableViewCell: UITableViewCell, Identifying {
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let deviceWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: deviceWidth, height: deviceWidth * 0.6)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: BackdropImageCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let pageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.backgroundStyle = .minimal
        return pageControl
    }()
    
    private let infoLabel = {
        let label = UILabel()
        label.textColor = .customGray
        label.font = AppFonts.body
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private var backdropURLs: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(movie: Movie, backdrops: [Backdrop]) {
        configureLabel(movie: movie)
        self.backdropURLs = backdrops.map { $0.filePath }
        pageControl.numberOfPages = backdrops.count
        collectionView.reloadData()
    }
    
    private func configureLabel(movie: Movie) {
        let attributedString = NSMutableAttributedString(string: "")
        
        let calendarAttachment = NSTextAttachment()
        calendarAttachment.image = UIImage(systemName: "calendar")?.withTintColor(.customGray)
        calendarAttachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        let starAttachment = NSTextAttachment()
        starAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.customGray)
        starAttachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        let filmAttachment = NSTextAttachment()
        filmAttachment.image = UIImage(systemName: "film.fill")?.withTintColor(.customGray)
        filmAttachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        
        attributedString.append(NSAttributedString(attachment: calendarAttachment))
        if let date = DateFormatters.yyyyMMddDashFormatter.date(from: movie.releaseDate) {
            attributedString.append(NSAttributedString(string: " \(DateFormatters.yyyyMMddDotFormatter.string(from: date))  |  "))
        }
        attributedString.append(NSAttributedString(attachment: starAttachment))
        let voteAverage = NumberFormatters.oneDigitFormatter.string(from: NSNumber(value: movie.voteAverage)) ?? "0.0"
        attributedString.append(NSAttributedString(string: " \(voteAverage)  |  "))
        attributedString.append(NSAttributedString(attachment: filmAttachment))
        
        let genres = movie.representativeGenre
        var genreString = " "
        for genre in genres {
            genreString += genre.name + ", "
        }
        genreString.removeLast(2)
        attributedString.append(NSAttributedString(string: genreString))
        
        infoLabel.attributedText = attributedString
    }
}

extension MovieInfoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        backdropURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: BackdropImageCollectionViewCell.self, for: indexPath)
        cell.configureData(imageURL: backdropURLs[indexPath.item])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension MovieInfoTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [collectionView, pageControl, infoLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.6)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView).inset(AppPadding.verticalInset)
            make.centerX.equalTo(collectionView)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(AppPadding.verticalInset)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
