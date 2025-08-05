//
//  Movie.swift
//  GigaBox
//
//  Created by 김영훈 on 8/4/25.
//

import Foundation

struct MovieResult: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let backdropPath: String?
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let genreIds: [Int]
    let releaseDate: String
    let voteAverage: Double
    
    var representativeGenre: [Genre] {
        var result = [Genre]()
        var count = 0
        for genreId in genreIds {
            if let genre = Genre(rawValue: genreId) {
                result.append(genre)
                count += 1
                if count == 2 { return result }
            }
        }
        return result
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let backdropSubPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        if let backdropSubPath {
            self.backdropPath = APIInfo.baseImageURLString + backdropSubPath
        } else {
            self.backdropPath = nil
        }
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        let posterSubPath = try container.decode(String.self, forKey: .posterPath)
        self.posterPath = APIInfo.baseImageURLString + posterSubPath
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    }
}
