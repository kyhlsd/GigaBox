//
//  NicknameDetailViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

final class NicknameDetailViewController: NicknameBaseViewController {
    
    private let statusLabel = {
        let label = UILabel()
        label.textColor = .customGreen
        label.font = AppFonts.detail
        return label
    }()
    
    private let nickname: String?
    private var nicknameErrorMessage: String?
    weak var delegate: NicknamePassingDelegate?
    
    init(nickname: String?) {
        self.nickname = nickname
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nicknameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.setNickname(nicknameTextField.text)
        delegate?.nicknameErrorMessage = nicknameErrorMessage
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        validateText(sender.text)
    }
    
    private func validateText(_ text: String?) {
        let min = 2
        let max = 9
        let baseString = "닉네임에 "
        do {
            let text = text
            try TextValidateHelper.validateLength(text, min: min, max: max)
            try TextValidateHelper.validateNumber(text)
            try TextValidateHelper.validateSpecialChar(text, specialChars: ["@", "#", "$", "%"])
            nicknameErrorMessage = nil
            statusLabel.text = "사용할 수 있는 닉네임이에요."
        } catch let error as NonValidTextError {
            if error.errorMessage == NonValidTextError.invalidLength(min: min, max: max).errorMessage {
                statusLabel.text = "닉네임을 " + error.errorMessage
                nicknameErrorMessage = "닉네임을 " + error.errorMessage
            } else {
                let errorMessage = baseString + error.errorMessage
                statusLabel.text = errorMessage
                nicknameErrorMessage = errorMessage
            }
        } catch {
            let errorMessage = baseString + NonValidTextError.unknown.errorMessage
            nicknameErrorMessage = errorMessage
            statusLabel.text = errorMessage
        }
    }
}

extension NicknameDetailViewController {
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(statusLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(baseLineView.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.equalTo(nicknameTextField)
        }
    }
    
    override func configureView() {
        super.configureView()

        nicknameTextField.isEnabled = true
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        nicknameTextField.text = nickname
        
        validateText(nickname)
    }
}
