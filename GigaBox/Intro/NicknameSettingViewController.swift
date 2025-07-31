//
//  NicknameSettingViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

final class NicknameSettingViewController: NicknameBaseViewController {
    
    private let editButton = RoundedButton(title: "편집", color: .customWhite)
    private let completeButton = RoundedButton(title: "완료", color: .customGreen)
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
    }
    
    @objc
    private func editButtonTapped() {
        guard let nickname = nicknameTextField.text else { return }
        let viewController = NicknameDetailViewController(nickname: nickname)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func completeButtonTapped() {
        print(#function)
    }
}

extension NicknameSettingViewController {
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [editButton, completeButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(AppPadding.verticalPadding)
            make.leading.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.trailing.equalTo(editButton.snp.leading)
            make.height.equalTo(44)
        }
        
        baseLineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.leading.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.trailing.equalTo(editButton.snp.leading).offset(22)
            make.height.equalTo(1)
        }
        
        editButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(nicknameTextField)
            make.trailing.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.width.equalTo(80)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(baseLineView.snp.bottom).offset(AppPadding.verticalPadding)
            make.horizontalEdges.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
}
