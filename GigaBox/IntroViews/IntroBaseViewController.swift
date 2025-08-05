//
//  IntroBaseViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import UIKit
import SnapKit

class IntroBaseViewController: UIViewController {

    private let splashImageView = {
        let imageView = UIImageView()
        imageView.image = .splash
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = AppFonts.onboarding
        label.textColor = .customWhite
        return label
    }()
    
    let subtitleLabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.textColor = .customLightGray
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDesign()
    }

}

extension IntroBaseViewController: ViewDesignProtocol {
    @objc
    func configureHierarchy() {
        [splashImageView, titleLabel, subtitleLabel].forEach {
            view.addSubview($0)
        }
    }
    
    @objc
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        splashImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(safeArea).offset(-80)
            make.size.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.equalTo(splashImageView.snp.bottom).offset(80)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.equalTo(titleLabel.snp.bottom).offset(AppPadding.verticalPadding)
        }
    }
    
    @objc
    func configureView() {
        view.backgroundColor = .customBlack
    }
}
