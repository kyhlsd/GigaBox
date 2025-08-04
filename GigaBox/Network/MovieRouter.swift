//
//  MovieRouter.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import Foundation
import Alamofire

enum MovieRouter: URLRequestConvertible {
    case getTrending
    
    var baseURL: URL {
        guard let url = URL(string: APIInfo.baseURLString) else { fatalError("baseURL Error") }
        return url
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var paths: String? {
        switch self {
        case .getTrending:
            return "3/trending/movie/day"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getTrending:
            return [
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "page", value: "1")
            ]
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(APIInfo.apiKey)"
        ]
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        if let paths { url = url.appendingPathComponent(paths) }
        url = url.appending(queryItems: queryItems)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        if let parameters {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
