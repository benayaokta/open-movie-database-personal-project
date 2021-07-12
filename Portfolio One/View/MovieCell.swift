//
//  MovieCell.swift
//  Portfolio One
//
//  Created by Benaya Oktavianus on 23/06/21.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageViewTableCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
