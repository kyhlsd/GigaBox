//
//  SettingViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {

    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        tableView.register(cellType: ProfileTableViewCell.self)
        tableView.register(cellType: SettingTableViewCell.self)
        return tableView
    }()
    
    private let settingList = ["", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewDesign()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    private func showAlert(title: String, message: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            handler()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension SettingViewController: TableViewReloadRowDelegate {
    func reloadRow(_ indexPath: IndexPath?) {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(cellType: ProfileTableViewCell.self, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(cellType: SettingTableViewCell.self, for: indexPath)
            cell.configureData(text: settingList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = NicknameSettingViewController()
            viewController.setEditingMode()
            viewController.delegate = self
            let navigationController = CustomNavigationController(rootViewController: viewController)
            present(navigationController, animated: true)
        case 4:
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴 하시겠습니까?") {
                UserDefaultManager.clear()
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
                        window.rootViewController = CustomNavigationController(rootViewController: OnboardingViewController())
                    }
                }
            }
        default:
            return
        }
    }
}

extension SettingViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .customBlack
        
        navigationItem.title = "설정"
        navigationItem.backButtonTitle = " "
    }
}
