//
//  MovieData.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import Foundation

struct Search: Decodable{
    let Search: [MovieData]
    let totalResults : String
    let Response : String
}

struct MovieData: Decodable {
    let Title : String
    let Year : String
    let imdbID : String
//    let Type : String
    let Poster : String
}
