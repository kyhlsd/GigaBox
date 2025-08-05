//
//  MovieDetailViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {

    private let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: MovieInfoTableViewCell.self)
        tableView.register(cellType: SynopsisTableViewCell.self)
        tableView.register(cellType: CastTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let movie: Movie
    private var backdrops: [Backdrop] = []
    private var casts: [ActorInfo] = []
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewDesign()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        callRequests()
    }
    
    private func callRequests() {
        let group = DispatchGroup()
        
        callBackdropRequest(group: group)
        callCreditRequest(group: group)
        
        group.notify(queue: .main) {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 2, section: 0)], with: .none)
        }
    }
    
    private func callBackdropRequest(group: DispatchGroup) {
        let url = MovieRouter.getBackdrop(id: movie.id)
        group.enter()
        NetworkManager.shared.fetchData(url: url, type: BackdropResult.self) { value in
            self.backdrops = value.representativeBackdrops
            group.leave()
        } failureHandler: { error in
            print(error)
            group.leave()
        }
    }
    
    private func callCreditRequest(group: DispatchGroup) {
        let url = MovieRouter.getCasts(id: movie.id)
        group.enter()
        NetworkManager.shared.fetchData(url: url, type: CastResult.self) { value in
            self.casts = value.cast
            group.leave()
        } failureHandler: { error in
            print(error)
            group.leave()
        }

    }
    
    @objc
    private func favoriteButtonTapped() {
        UserDefaultManager.MovieBox.toggleItemInMovieBox(movie.id)
        let image = UserDefaultManager.MovieBox.getFavoriteImage(movie.id)
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: image)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(cellType: MovieInfoTableViewCell.self, for: indexPath)
            cell.configureData(movie: movie, backdrops: backdrops)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(cellType: SynopsisTableViewCell.self, for: indexPath)
            cell.delegate = self
            cell.configureData(text: movie.overview)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(cellType: CastTableViewCell.self, for: indexPath)
            cell.configureData(casts: casts)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailViewController: TableViewReloadRowDelegate {
    func reloadRow() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension MovieDetailViewController: ViewDesignProtocol {
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
        
        navigationItem.title = movie.title
        let image = UserDefaultManager.MovieBox.getFavoriteImage(movie.id)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: image), style: .plain, target: self, action: #selector(favoriteButtonTapped))
    }
}
