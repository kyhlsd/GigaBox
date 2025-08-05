//
//  MovieAPIError.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import Foundation

enum APIError: Error {
    case unknown(Error)
    case apiError(MovieAPIError)
}

struct MovieAPIError: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
    }
}
