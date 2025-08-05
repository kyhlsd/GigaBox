//
//  TodayMovieTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import UIKit

final class TodayMovieTableViewCell: UITableViewCell, Identifying {
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "오늘의 영화"
        label.font = AppFonts.header
        label.textColor = .customWhite
        return label
    }()
    
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = AppPadding.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: AppPadding.horizontalPadding, bottom: 0, right: AppPadding.horizontalPadding)
        layout.itemSize = CGSize(width: 200, height: 400)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: TodayMovieCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var trendingMovies: [Movie] = []
    weak var delegate: PushDetailVCDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(movies: [Movie]) {
        trendingMovies = movies
        collectionView.reloadData()
    }
}

extension TodayMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: TodayMovieCollectionViewCell.self, for: indexPath)
        cell.movie = trendingMovies[indexPath.item]
        cell.configureData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = trendingMovies[indexPath.item]
        delegate?.pushDetailViewController(movie: movie, indexPath: indexPath)
    }
}

extension TodayMovieTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [titleLabel, collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(AppPadding.horizontalPadding)
            make.top.equalToSuperview().inset(AppPadding.verticalPadding)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(400)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
