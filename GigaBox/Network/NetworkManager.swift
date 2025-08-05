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
    
    func fetchData<T: Decodable>(url: URLRequestConvertible, type: T.Type, successHandler: @escaping (T) -> Void, failureHandler: @escaping (APIError) -> Void) {
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(let error):
                    if let data = response.data, let apiError = try? JSONDecoder().decode(MovieAPIError.self, from: data) {
                        failureHandler(APIError.apiError(apiError))
                    } else {
                        failureHandler(APIError.unknown(error))
                    }
                }
            }
    }
}
