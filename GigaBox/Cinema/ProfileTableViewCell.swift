//
//  ProfileTableViewCell.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: UITableViewCell, Identifying {

    private let containerView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = CornerRadius.medium
        view.clipsToBounds = true
        return view
    }()
    
    private let nicknameLabel = {
        let label = UILabel()
        label.text = UserDefaultManager.nickname
        label.font = AppFonts.title
        label.textColor = .customWhite
        return label
    }()
    
    private let signUpDateLabel = {
        let label = UILabel()
        if let date = UserDefaultManager.signUpDate {
            label.text = DateFormatters.yyMMddDotFormatter.string(from: date) + " 가입"
        } else {
            label.text = "날짜를 불러오지 못했습니다."
        }
        label.font = AppFonts.detail
        label.textColor = .customLightGray
        return label
    }()

    private let profileEditButton = {
        let button = UIButton()
        button.tintColor = .customLightGray
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return button
    }()
    
    private let movieBoxButton = {
        let button = UIButton()
        button.setTitle("\(UserDefaultManager.moviebox.count)개의 무비박스 보관중", for: .normal)
        button.setTitleColor(.customWhite, for: .normal)
        button.backgroundColor = .customGreen.withAlphaComponent(0.6)
        button.layer.cornerRadius = CornerRadius.small
        button.clipsToBounds = true
        return button
    }()
    
    var presentNicknameSetting: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        
        profileEditButton.addTarget(self, action: #selector(profileEditButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nicknameLabel.text = UserDefaultManager.nickname
        movieBoxButton.setTitle("\(UserDefaultManager.moviebox.count)개의 무비박스 보관중", for: .normal)
    }
    
    @objc
    private func profileEditButtonTapped() {
        presentNicknameSetting?()
    }
}

extension ProfileTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [nicknameLabel, signUpDateLabel, profileEditButton, movieBoxButton].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(AppPadding.horizontalPadding)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppPadding.verticalInset)
            make.leading.equalToSuperview().inset(AppPadding.horizontalInset)
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppPadding.horizontalInset)
            make.centerY.equalTo(nicknameLabel)
            make.size.equalTo(24)
        }
        
        signUpDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(profileEditButton.snp.leading).offset(4)
            make.centerY.equalTo(nicknameLabel)
        }
        
        movieBoxButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalToSuperview().inset(AppPadding.horizontalInset)
            make.bottom.equalToSuperview().inset(AppPadding.verticalInset)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
    }
}
