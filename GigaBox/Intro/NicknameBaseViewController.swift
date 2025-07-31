//
//  NicknameBaseViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import UIKit
import SnapKit

class NicknameBaseViewController: UIViewController {

    let nicknameTextField = {
        let textField = UITextField()
        textField.textColor = .customWhite
        textField.attributedPlaceholder = NSAttributedString(string: "편집 버튼으로 닉네임을 설정해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGray])
        textField.isEnabled = false
        textField.borderStyle = .none
        return textField
    }()
    
    let baseLineView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewDesign()
    }
    
}

extension NicknameBaseViewController: ViewDesignProtocol {
    @objc
    func configureHierarchy() {
        [nicknameTextField, baseLineView].forEach {
            view.addSubview($0)
        }
    }
    
    @objc
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(AppPadding.verticalPadding)
            make.horizontalEdges.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.height.equalTo(44)
        }
        
        baseLineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.horizontalEdges.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.height.equalTo(1)
        }
    }
    
    @objc
    func configureView() {
        view.backgroundColor = .customBlack
        
        navigationItem.title = "닉네임 설정"
        navigationItem.backButtonTitle = " "
    }
}
