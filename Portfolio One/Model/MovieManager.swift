//
//  MovieManager.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import Foundation

struct MovieManager {
    let apiKey = "9c930033"
    let baseURL = "https://www.omdbapi.com/"
    
    func fetchData(movie name:String){
        let searchURL = "\(baseURL)?s=\(name)?apikey=\(apiKey)"
        print(searchURL)
    }
    
    private func performFetchRequest(){
        
    }
    
}
