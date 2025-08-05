//
//  CinemaHomeViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/1/25.
//

import UIKit
import SnapKit

protocol TableViewReloadRowDelegate: AnyObject {
    func reloadRow(_ indexPath: IndexPath?)
}

protocol PushDetailVCDelegate: AnyObject {
    func pushDetailViewController(movie: Movie, indexPath: IndexPath)
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
    
    private var trendingMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDesign()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        callRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    private func callRequest() {
        let url = MovieRouter.getTrending
        NetworkManager.shared.fetchData(url: url, type: MovieResult.self) { value in
            self.trendingMovies = value.results
            self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        } failureHandler: { error in
            print(error)
        }
    }
    
    @objc
    private func searchButtonTapped() {
        navigationController?.pushViewController(SearchMovieViewController(), animated: true)
    }
    
}

extension CinemaHomeViewController: TableViewReloadRowDelegate {
    func reloadRow(_ indexPath: IndexPath?) {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
}

extension CinemaHomeViewController: PushDetailVCDelegate {
    func pushDetailViewController(movie: Movie, indexPath: IndexPath) {
        let viewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
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
            let cell = tableView.dequeueReusableCell(cellType: TodayMovieTableViewCell.self, for: indexPath)
            cell.configureData(movies: trendingMovies)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController = NicknameSettingViewController()
            viewController.setEditingMode()
            viewController.delegate = self
            let navigationController = CustomNavigationController(rootViewController: viewController)
            present(navigationController, animated: true)
        }
    }
}

extension CinemaHomeViewController: ViewDesignProtocol {
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
        
        navigationItem.title = "GigaBox"
        navigationItem.backButtonTitle = " "
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    
}
