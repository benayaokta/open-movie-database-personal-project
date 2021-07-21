//
//  ViewController.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var emptyStateImage: UIImageView!{
        didSet{
            emptyStateImage.image = UIImage(systemName: "photo")
            emptyStateImage.contentMode = .scaleAspectFit
            emptyStateImage.clipsToBounds = true
            emptyStateImage.isHidden = true
        }
    }
    
    @IBOutlet weak var initialLabel: UILabel!{
        didSet{
            initialLabel.isHidden = false
        }
    }
    
    var movieManager = Apicall()
    
    var movieModel: [MovieModel] = []
    
    var selectedRow: MovieModel?
    
    var initialPage = 1
    
    var fetchMore = false
    
    var textFromSB = ""
    
    let searchBar = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
            tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshControlFunc), for: .valueChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()

    }
    
    deinit {
        print(#function)
        print(textFromSB, initialPage, fetchMore)
    }
    
    private func initialSetup() {
        self.navigationItem.title = "Search Movies"
        self.navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > (contentHeight - scrollView.frame.height)
        {
            if !fetchMore
            {
                fetchMoreDataForInfiniteScroll()
            }
        }
    }
    
    fileprivate func fetchMoreDataForInfiniteScroll()
    {
        fetchMore = true
        initialPage += 1
        movieManager.performFetchRequest(movieName: textFromSB, page: initialPage) { movieData in
            self.movieModel.append(contentsOf: movieData)
            DispatchQueue.main.async{ [self] in
                fetchMore = false
                tableView.reloadData()
            }
        }
    }
    
    @objc func refreshControlFunc()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
        
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.movieModel.removeAll()
        textFromSB = searchText
        movieManager.performFetchRequest(movieName: textFromSB, page: initialPage) { [self] movieData in
            
            movieModel = movieData
            
            DispatchQueue.main.async {
                tableView.reloadData()
                initialLabel.isHidden = true
                tableView.isHidden = false
                
                tableView.refreshControl?.endRefreshing()
            }
        }
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {
            
            UIImageView().kf.setImage(with: URL(string: movieModel[indexPath.row].poster), placeholder: nil, options: .none, progressBlock: .none) { [weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let value):
                    cell.imageViewTableCell.image = value.image
                    cell.imageViewTableCell.clipsToBounds = true
                    cell.imageViewTableCell.contentMode = .scaleAspectFit
                case .failure(_):
                    cell.imageViewTableCell.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .light, scale: .small))
                    cell.imageViewTableCell.contentMode = .scaleAspectFit
                    print("Fail to load image.")
                }
            }
            
            cell.label.text = movieModel[indexPath.row].title
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = movieModel[indexPath.row]
        performSegue(withIdentifier: DetailViewController.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.segueIdentifier{
            if let destinationVC = segue.destination as? DetailViewController{
                destinationVC.movieDetail = selectedRow
            }
            
        }
    }
    
    

}
