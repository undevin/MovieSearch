//
//  Movie.swift
//  MovieSearch
//
//  Created by Devin Flora on 1/29/21.
//

import Foundation

struct TopLevelObject: Decodable {
    let results: [Movie]
}//End of Struct

struct Movie: Decodable {
    let originalTitle: String
    let overview: String
    let voteAverage: Float
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey{
        case originalTitle = "original_title"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}//End of Struct
