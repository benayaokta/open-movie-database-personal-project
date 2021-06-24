//
//  MovieModel.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 24/06/21.
//

import Foundation

struct MovieModel {
    let title: String
    let year:String
    let id:String
    let poster: String
    
    init(t:String, y:String,i:String,p:String) {
        title = t
        year = y
        id = i
        poster = p
    }
}
