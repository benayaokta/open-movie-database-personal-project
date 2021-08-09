//
//  ViewController.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 22/06/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    let rootVM = RootViewModel()
    var items = [MovieModel]()
    
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
    
    private func initialSetup() {
        self.navigationItem.title = "Search Movies"
        self.navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
        
        rootVM.delegate = self
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > (contentHeight - scrollView.frame.height)
        {
            rootVM.checkConditionInfiniteScroll()

        }
    }

    
    @objc func refreshControlFunc()
    {
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
        
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(#function)
        guard let searchText = searchBar.text else { return }
        print(searchText)
        
        rootVM.searchButtonClick(search: searchText)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {
            let posterPath = items[indexPath.row].poster
            let posterTitle = items[indexPath.row].title
            
            UIImageView().kf.setImage(with: URL(string: posterPath), placeholder: nil, options: .none, progressBlock: .none) { [weak self] (result) in
                guard let self = self else { return }
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
            
            cell.label.text = posterTitle
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rootVM.selectedRow = rootVM.movieItems[indexPath.row]
        performSegue(withIdentifier: DetailViewController.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.segueIdentifier{
            if let destinationVC = segue.destination as? DetailViewController{
                destinationVC.movieDetail = rootVM.selectedRow
            }
            
        }
    }
    
    

}

extension ViewController: RootViewModelDelegate{
    func updateSearch(_ data: [MovieModel]) {
        self.items = data
        
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            tableView.isHidden = false
            tableView.refreshControl?.endRefreshing()
        }
    }
}
