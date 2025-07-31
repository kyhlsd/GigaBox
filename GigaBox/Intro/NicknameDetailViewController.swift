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
    
    private let nickname: String
    
    init(nickname: String) {
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
        print(#function)
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        print(#function)
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
        nicknameTextField.text = nickname
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}
