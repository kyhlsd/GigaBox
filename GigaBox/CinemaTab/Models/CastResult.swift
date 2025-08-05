//
//  CastResult.swift
//  GigaBox
//
//  Created by 김영훈 on 8/5/25.
//

import Foundation

struct CastResult: Decodable {
    let id: Int
    let cast: [ActorInfo]
}

struct ActorInfo: Decodable {
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case profilePath = "profile_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.character = try container.decode(String.self, forKey: .character)
        let subPath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        if let subPath {
            self.profilePath = APIInfo.baseImageURLString + subPath
        } else {
            self.profilePath = nil
        }
    }
}
