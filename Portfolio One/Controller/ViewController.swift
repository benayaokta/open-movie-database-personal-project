//
//  ViewController.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    var movieManager = MovieManager()
//    let movieData = MovieData
    let movieModel: [MovieModel] = []
    let searchBar = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialSetup()
        searchBar.searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initialSetup() {
        self.navigationItem.title = "Search Movies"
        self.navigationItem.searchController = searchBar
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        movieManager.fetchData(movie: searchText)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.imageview.image = UIImage(named: "pencil")
//        cell.label.text = movieData.Tit
//        cell.label.text = movieda
        return cell
    }

}
