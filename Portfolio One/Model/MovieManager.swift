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
                
                if err != nil{ return }
                if response.statusCode == 200{
                    parseJSON(data: data)
                }
            }
            //start task
            task.resume()
        }
        
    }
    
    fileprivate func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        
        do {
            let temp = try decoder.decode(Search.self, from: data)
            
            let search = temp.Search
            
            for i in 0...search.count-1 {
                print("i \(i)", search[i].Title)
//                let searchName = search[i].Title
            MovieModel(title: search[i].Title, year: search[i].Year, id: search[i].imdbID, type: search[i].Type, poster: search[i].Poster)
                
            }
            
            MovieModel(title: search[0].Title, year: search[0].Year, id: search[0].imdbID, type: search[0].Type, poster: search[0].Poster)
//            return MovieModel(title: Strings, year: <#T##String#>, id: <#T##String#>, type: <#T##String#>, poster: <#T##String#>)
            
        } catch {
            print(error)
//            return nil
        }
        
    }
    
}
