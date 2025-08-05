//
//  Backdrop.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import Foundation

struct BackdropResult: Decodable {
    let id: Int
    let backdrops: [Backdrop]
    var representativeBackdrops: [Backdrop] {
        var result: [Backdrop] = []
        var count = 0
        for backdrop in backdrops {
            result.append(backdrop)
            count += 1
            if count == 5 { return result }
        }
        return result
    }
}

struct Backdrop: Decodable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let subPath = try container.decode(String.self, forKey: .filePath)
        self.filePath = APIInfo.baseImageURLString + subPath
    }
}
