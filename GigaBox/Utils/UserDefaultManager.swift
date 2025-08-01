//
//  UserDefaultManager.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import Foundation

enum UserDefaultManager {
    @UserDefault(key: "nickname", defaultValue: nil)
    static var nickname: String?
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
