//
//  ActorInfoTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ActorInfoTableViewCell: UITableViewCell, Identifying {

    private let profileImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .customGray
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let nameLabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.textColor = .customWhite
        return label
    }()
    
    private let characterLabel = {
        let label = UILabel()
        label.font = AppFonts.detail
        label.textColor = .customGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        nameLabel.text = nil
        characterLabel.text = nil
    }
    
    override func draw(_ rect: CGRect) {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configureData(actorInfo: ActorInfo) {
        if let image = actorInfo.profilePath {
            let url = URL(string: image)
            profileImageView.kf.setImage(with: url, options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 30, height: 30))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        } else {
            profileImageView.image = UIImage(systemName: "person.fill")
        }
        
        nameLabel.text = actorInfo.name
        characterLabel.text = actorInfo.character
    }
}

extension ActorInfoTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [profileImageView, nameLabel, characterLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(AppPadding.verticalInset)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(AppPadding.horizontalInset)
            make.centerY.equalToSuperview()
        }
        
        characterLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(AppPadding.horizontalInset)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
