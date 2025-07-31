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
    
    private let titleLabel = {
        let label = UILabel()
        label.font = AppFonts.onboarding
        label.textColor = .customWhite
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDesign()
    }

    private func setLabelText(_ label: UILabel, text: String) {
        label.text = text
    }
}

extension IntroBaseViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [splashImageView, titleLabel].forEach {
            view.addSubview($0)
        }
    }
    
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
    }
    
    func configureView() {
        view.backgroundColor = .customBlack
    }
}
