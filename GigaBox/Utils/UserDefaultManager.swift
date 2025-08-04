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
    
    @UserDefault(key: "MovieBox", defaultValue: [])
    static var moviebox: [Int]
    
    static func isInMovieBox(_ id: Int) -> Bool {
        return moviebox.contains(id)
    }
    
    static func toggleItemInMovieBox(_ id: Int) {
        if let index = moviebox.firstIndex(of: id) {
            moviebox.remove(at: index)
        } else {
            moviebox.append(id)
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
