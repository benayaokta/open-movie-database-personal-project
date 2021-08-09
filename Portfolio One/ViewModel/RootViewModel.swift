//
//  RootViewModel.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 21/07/21.
//

import Foundation

protocol RootViewModelDelegate{
    func updateSearch(_ data: [MovieModel])
}

class RootViewModel{
    
    let apiCall = Apicall()
    
    var movieItems = [MovieModel]()
    
    var selectedRow: MovieModel?
    
    var initialPage = 1
    
    var fetchMore = false
    
    var textFromSB : String?
    
    var delegate: RootViewModelDelegate?
    
    
    func searchButtonClick(search:String)
    {
        
        initialPage = 1
        textFromSB = search

        apiCall.performFetchRequest(movieName: textFromSB ?? "", page: initialPage) { [weak self] movieData in
            guard let strongSelf = self else {return}
            strongSelf.movieItems = movieData

            strongSelf.delegate?.updateSearch(strongSelf.movieItems)
        }
    }

    func fetchMoreFromInfiniteScroll()
    {
        fetchMore = true
        initialPage += 1
        apiCall.performFetchRequest(movieName: textFromSB ?? "", page: initialPage) { [weak self] movieData in
            guard let self = self else {return}
            self.movieItems.append(contentsOf: movieData)

            self.fetchMore = false
            self.delegate?.updateSearch(self.movieItems)

        }
    }

    func checkConditionInfiniteScroll()
    {
        if !fetchMore
        {
            fetchMoreFromInfiniteScroll()
        }
    }
    
}
