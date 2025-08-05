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

    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .customLightGray
        return imageView
    }()
    
    private let movieBoxButton = {
        let button = UIButton()
        button.setTitle("\(UserDefaultManager.MovieBox.list.count)개의 무비박스 보관중", for: .normal)
        button.setTitleColor(.customWhite, for: .normal)
        button.backgroundColor = .customGreen.withAlphaComponent(0.6)
        button.layer.cornerRadius = CornerRadius.small
        button.clipsToBounds = true
        return button
    }()
    
    weak var delegate: TableViewReloadRowDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewDesign()
        movieBoxButton.addTarget(self, action: #selector(movieBoxButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMovieBoxButton), name: .movieBoxChanged, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nicknameLabel.text = UserDefaultManager.nickname
        movieBoxButton.setTitle("\(UserDefaultManager.MovieBox.list.count)개의 무비박스 보관중", for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func updateMovieBoxButton() {
        movieBoxButton.setTitle("\(UserDefaultManager.MovieBox.list.count)개의 무비박스 보관중", for: .normal)
    }
    
    @objc
    private func movieBoxButtonTapped() {
        print(#function)
    }
}

extension ProfileTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [nicknameLabel, signUpDateLabel, chevronImageView, movieBoxButton].forEach {
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
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppPadding.horizontalInset)
            make.centerY.equalTo(nicknameLabel)
            make.width.equalTo(16)
            make.height.equalTo(24)
        }
        
        signUpDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chevronImageView.snp.leading).inset(-8)
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
        selectionStyle = .none
    }
}
