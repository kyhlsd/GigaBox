//
//  UserDefaultManager.swift
//  GigaBox
//
//  Created by 김영훈 on 7/31/25.
//

import Foundation

enum UserDefaultManager {
    @UserDefault(key: "Nickname", defaultValue: nil)
    static var nickname: String?
    
    @UserDefault(key: "SignUpDate", defaultValue: nil)
    static var signUpDate: Date?
    
    enum MovieBox {
        @UserDefault(key: "MovieBox", defaultValue: [])
        static var list: [Int]
        
        static func getFavoriteImage(_ id: Int) -> String {
            return list.contains(id) ? "heart.fill" : "heart"
        }
        
        static func toggleItemInMovieBox(_ id: Int) {
            if let index = list.firstIndex(of: id) {
                list.remove(at: index)
            } else {
                list.append(id)
            }
        }
    }
    
    @UserDefault(key: "SearchedWords", defaultValue: [])
    static var searchedWords: [String]
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
