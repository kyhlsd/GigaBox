//
//  UIViewController+Extension.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import UIKit

extension UIViewController {
    func showDefaultAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func showCancelAlert(title: String, message: String, handler: @escaping () -> Void) {
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
