//
//  NicknameSettingViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit
import Toast

protocol NicknamePassingDelegate: AnyObject {
    func setNickname(_ nickname: String?)
    var nicknameErrorMessage: String? { get set }
}

final class NicknameSettingViewController: NicknameBaseViewController {
    
    private let editButton = RoundedButton(title: "편집", color: .customWhite)
    private let completeButton = RoundedButton(title: "완료", color: .customGreen)
    
    var nickname = UserDefaultManager.nickname
    var nicknameErrorMessage: String?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nicknameTextField.text = nickname
    }
    
    @objc
    private func editButtonTapped() {
        let viewController = NicknameDetailViewController(nickname: nickname)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func completeButtonTapped() {
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = .customWhite
        toastStyle.messageColor = .customBlack
        
        guard let nickname, !nickname.isEmpty else {
            let errorMessage = "닉네임을 " + NonValidTextError.invalidLength(min: 2, max: 9).errorMessage
            view.makeToast(errorMessage, duration: 2, position: .bottom, style: toastStyle)
            return
        }
        
        if let nicknameErrorMessage {
            view.makeToast(nicknameErrorMessage, duration: 2, position: .bottom, style: toastStyle)
        } else {
            UserDefaultManager.nickname = nickname
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                DispatchQueue.main.async {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                        window.rootViewController = ViewController()
                    }
                }
            }
        }
    }
}

extension NicknameSettingViewController: NicknamePassingDelegate {
    func setNickname(_ nickname: String?) {
        nicknameTextField.text = nickname
        self.nickname = nickname
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
