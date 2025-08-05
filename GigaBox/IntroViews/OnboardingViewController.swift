//
//  OnboardingViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import UIKit

final class OnboardingViewController: IntroBaseViewController {

    private let startButton = RoundedButton(title: "시작하기", color: .customGreen)
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc
    private func startButtonTapped() {
        navigationController?.pushViewController(NicknameSettingViewController(), animated: true)
    }
}

extension OnboardingViewController {
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(startButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        startButton.snp.makeConstraints { make in
            let safeArea = view.safeAreaLayoutGuide
            
            make.horizontalEdges.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        titleLabel.text = "Onboarding"
        subtitleLabel.text = "당신만의 영화 세상,\nGigaBox를 시작해보세요."
        
        navigationItem.backButtonTitle = " "
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
}
