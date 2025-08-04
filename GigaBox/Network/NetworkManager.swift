//
//  NetworkManager.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(url: URLRequestConvertible, successHandler: @escaping (MovieResult) -> Void, failureHandler: @escaping (Error) -> Void) {
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieResult.self) { response in
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(let error):
                    failureHandler(error)
                }
            }
    }
}
