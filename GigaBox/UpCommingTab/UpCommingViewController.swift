//
//  UpCommingViewController.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit
import SnapKit

final class UpCommingViewController: UIViewController {

    private let label = {
        let label = UILabel()
        label.text = "UPCOMMING"
        label.textColor = .customGray
        label.font = AppFonts.body
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewDesign()
    }
}

extension UpCommingViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(label)
    }
    
    func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .customBlack
        
        navigationItem.title = "UpComming"
    }
}
