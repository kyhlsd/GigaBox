//
//  CinemaHomeViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

protocol TableViewReloadRowDelegate: AnyObject {
    func reloadRow()
}

final class CinemaHomeViewController: UIViewController {
    
    private let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: ProfileTableViewCell.self)
        tableView.register(cellType: RecentWordsTableViewCell.self)
        tableView.register(cellType: TodayMovieTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDesign()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc
    private func searchButtonTapped() {
        print(#function)
    }
    
}

extension CinemaHomeViewController: TableViewReloadRowDelegate {
    func reloadRow() {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
}

extension CinemaHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(cellType: ProfileTableViewCell.self, for: indexPath)
        case 1:
            return tableView.dequeueReusableCell(cellType: RecentWordsTableViewCell.self, for: indexPath)
        case 2:
            return tableView.dequeueReusableCell(cellType: TodayMovieTableViewCell.self, for: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController = NicknameSettingViewController()
            viewController.setEditingMode()
            viewController.delegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.tintColor = .customGreen
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
            present(navigationController, animated: true)
        }
    }
}

extension CinemaHomeViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(AppPadding.verticalPadding)
            make.horizontalEdges.equalTo(safeArea)
            make.bottom.equalTo(safeArea)
        }
    }
    
    func configureView() {
        view.backgroundColor = .customBlack
        
        navigationItem.title = "GigaBox"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    
}
