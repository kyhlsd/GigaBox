//
//  SearchMovieViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit
import Toast

final class SearchMovieViewController: UIViewController {

    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력하세요."
        searchBar.searchTextField.textColor = .customWhite
        searchBar.tintColor = .customWhite
        searchBar.searchTextField.leftView?.tintColor = .customWhite
        searchBar.searchTextField.borderStyle = .none
        searchBar.backgroundColor = .customGray
        searchBar.backgroundImage = UIImage()
        searchBar.returnKeyType = .search
        searchBar.layer.cornerRadius = CornerRadius.medium
        searchBar.clipsToBounds = true
        return searchBar
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .customGray
        tableView.register(cellType: SearchedMovieTableViewCell.self)
        tableView.register(cellType: EmptySearchedTableViewCell.self)
        return tableView
    }()
    
    private var movies: [Movie] = []
    private var page = 1
    private var isEnd = false
    private var prevSearchWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewDesign()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }

    private func callRequest(keyword: String) {
        let url = MovieRouter.getSearched(keyword: keyword, page: page)
        NetworkManager.shared.fetchData(url: url, type: SearchedResult.self) { value in
            self.movies.append(contentsOf: value.results)
            self.tableView.separatorStyle = self.movies.isEmpty ? .none : .singleLine
            self.isEnd = value.isEnd
            self.tableView.reloadData()
            if value.page == 1 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        } failureHandler: { error in
            print(error)
        }
    }
    
    func setInitialSearchWord(keyword: String) {
        searchBar.text = keyword
        callRequest(keyword: keyword)
    }
}

extension SearchMovieViewController: TableViewReloadRowDelegate {
    func reloadRow(_ indexPath: IndexPath?) {
        if let indexPath {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if searchText.isEmpty {
            var toastStyle = ToastStyle()
            toastStyle.backgroundColor = .customWhite
            toastStyle.messageColor = .customBlack
            
            view.makeToast("검색어를 입력해주세요.", duration: 2, position: .bottom, style: toastStyle)
            return
        }
        
        UserDefaultManager.SearchWords.addWord(text: searchText)
        
        movies.removeAll()
        prevSearchWord = searchText
        page = 1
        callRequest(keyword: searchText)
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(searchBar.text ?? "").isEmpty, movies.isEmpty {
            return 1
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !(searchBar.text ?? "").isEmpty, movies.isEmpty {
            return tableView.dequeueReusableCell(cellType: EmptySearchedTableViewCell.self, for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(cellType: SearchedMovieTableViewCell.self, for: indexPath)
        cell.configureData(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !(searchBar.text ?? "").isEmpty, movies.isEmpty {
            return 320
        }
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MovieDetailViewController(movie: movies[indexPath.row])
        viewController.indexPath = indexPath
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 6, !isEnd {
            page += 1
            isEnd = true
            callRequest(keyword: prevSearchWord)
        }
    }
}

extension SearchMovieViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.horizontalEdges.equalTo(safeArea).inset(AppPadding.horizontalPadding)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(AppPadding.verticalInset)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    func configureView() {
        view.backgroundColor = .customBlack
        
        navigationItem.title = "영화 검색"
        navigationItem.backButtonTitle = " "
    }
}
