//
//  DetailViewController.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 21/07/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    static let segueIdentifier = "toDetail"
    
    var movieDetail : MovieModel?
    
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!{
        didSet{
            movieTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            movieTitle.preferredMaxLayoutWidth = CGFloat(210)
        }
    }
    @IBOutlet weak var year: UILabel!{
        didSet{
            year.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    @IBOutlet weak var imdbID: UILabel!{
        didSet{
            imdbID.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    @IBOutlet weak var type: UILabel!{
        didSet{
            type.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        setupData()
    }
    
    private func setupData()
    {
        guard let movieDetail = movieDetail else { return }
        imagePoster.kf.setImage(with: URL(string: movieDetail.poster), placeholder: nil, options: .none, progressBlock: .none) { [weak self] (result) in
            guard let strongSelf = self else { fatalError() }
            switch result {
            case .success(let value):
                strongSelf.imagePoster.image = value.image
                strongSelf.imagePoster.clipsToBounds = true
                strongSelf.imagePoster.contentMode = .scaleAspectFit
            case .failure(_):
                strongSelf.imagePoster.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .light, scale: .default))
                print("Fail to load image")
                
            }
        }
        
        movieTitle.text = movieDetail.title
        year.text = "Year released: \(movieDetail.year)"
        imdbID.text = "imdb ID: \(movieDetail.id)"
        type.text = movieDetail.type.capitalized
    }
    
    deinit {
        movieDetail = nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
