//
//  MoviePoster.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import Foundation

struct MoviePoster: Decodable {
    let title:String
    let year:String
    let imdbID:String
    let type:String
    let poster:URL
    
    enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
