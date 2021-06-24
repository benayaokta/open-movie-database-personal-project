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
        let temp = modifyString(name)
        let searchURL = baseURL+"?s=\(temp)&apikey=\(apiKey)"
        performFetchRequest(searchURL)
    }
    
    private func modifyString(_ string:String)->String{
        return string.replacingOccurrences(of: " ", with: "+")
    }
    
    fileprivate func performFetchRequest(_ urlString: String){
        // create URL
        if let url = URL(string: urlString)  {

            //create URLSession
            let urlSession = URLSession(configuration: .default)
            
            //give task
            let task = urlSession.dataTask(with: url) { data, response, err in
                guard let data = data, let response = response as? HTTPURLResponse else {return}
                
                if err != nil{
                    return
                }
                
                if response.statusCode == 200{
                    parseJSON(data: data)
                }
            }
            //start task
            task.resume()
        }

    }
    
    fileprivate func parseJSON(data: Data){
        let decoder = JSONDecoder()

        do {
//            let decodedJSON = try decoder.decode(MovieData.self, from: data)
            let temp = try decoder.decode(Search.self, from: data)
//            
//            print(decodedJSON)
//            
            let search = temp.Search
            let result = temp.totalResults
            let response = temp.Response
            
            print(search, result, response)
//            
//            print(search)
//
//            let title = decodedJSON.Title
//            let year = decodedJSON.Year
//            let id = decodedJSON.imdbID
//            let poster = decodedJSON.Poster

//            let data = MovieData(Title: title, Year: year, imdbID: id, Poster: poster)
//            MovieModel(t: title, y: year, i: id, p: poster)
            
//            return data
            

        } catch {
            print(error)
//            return nil
            
        }

    }

}
