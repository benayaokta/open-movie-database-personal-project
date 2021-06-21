//
//  ViewController.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    let movieManager = MovieManager()
    let searchBar = UISearchController(searchResultsController: nil)
    
    let label : UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "Find your favorite movies!"
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return tempLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialSetup()
        setupConstraint()
        searchBar.searchBar.delegate = self
        
        movieManager.fetchData(movie: "Kungfu")
        
    }
    
    private func initialSetup() {
        self.navigationItem.title = "Search Movies"
        self.navigationItem.searchController = searchBar
        
        view.addSubview(label)
    }
    
    private func setupConstraint() {
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 400).isActive = true
        
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //        label.textAlignment = .center
    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}

