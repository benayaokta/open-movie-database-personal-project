//
//  MovieManager.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import Foundation

struct Apicall {
    let apiKey = "?apikey=9c930033"
    let baseURL = "https://www.omdbapi.com/"
    let searchParam = "&s="
    let pages = "&page="
    
    private func modifyString(_ string:String)->String{
        return string.replacingOccurrences(of: " ", with: "+")
    }
    
    func performFetchRequest(movieName name: String, page:Int ,completion: @escaping ([MovieModel]) -> Void){
        var movieModel = [MovieModel]()
        let temp = modifyString(name)
        let searchURL = "\(baseURL)\(apiKey)\(searchParam)\(temp)\(pages)\(page)"
        
        // create URL
        if let url = URL(string: searchURL)  {

//            print(url)
            //create URLSession
            let urlSession = URLSession(configuration: .default)
            
            //give task
            let task = urlSession.dataTask(with: url, completionHandler: {data, response, error in
                guard let response = response as? HTTPURLResponse else {return}
                
                if error != nil{ return }
                if response.statusCode == 200{
                    if let data = data{
                        
                        let decoder = JSONDecoder()
                        
                        do {
                            let temp = try decoder.decode(Search.self, from: data)
                            let search = temp.Search
                            
                            for i in 0...search.count-1 {
                                let title = search[i].Title
                                let year = search[i].Year
                                let id = search[i].imdbID
                                let type = search[i].Type
                                let poster = search[i].Poster
                                
                                movieModel.append(MovieModel(title: title, year: year, id: id, type: type, poster: poster))
                            }
                            
                            completion(movieModel)
                            
                        } catch {
                            print(error, error.localizedDescription)
                        }
                        
                    }
                        
                    
                }

            })
            
            //start task
            task.resume()
        }
        
    }
}
