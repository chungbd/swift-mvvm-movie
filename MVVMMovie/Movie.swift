//
//  Movie.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import Foundation

struct Movie: Decodable {
    let Title: String
    let Year: String
    let type: String
    let Runtime: String
    let imdbRating: String
    let Plot: String
    let imdbVotes: String
    let Metascore: String
    let Director: String
    let Writer:String
    let Actors:String
    let Poster:URL
    
    enum CodingKeys: String, CodingKey {
        case Title, Year, Runtime, imdbRating, Plot, imdbVotes, Metascore, Director, Writer, Actors, Poster
        case type = "Type"
    }
}
