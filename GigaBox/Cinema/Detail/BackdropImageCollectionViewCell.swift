//
//  BackdropImageCollectionViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import UIKit
import Kingfisher

final class BackdropImageCollectionViewCell: UICollectionViewCell, Identifying {
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configureData(imageURL: String) {
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url, options: [
            .processor(DownsamplingImageProcessor(size: CGSize(width: 400, height: 300))),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
        ])
    }
}

extension BackdropImageCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() { }
    
    
}
