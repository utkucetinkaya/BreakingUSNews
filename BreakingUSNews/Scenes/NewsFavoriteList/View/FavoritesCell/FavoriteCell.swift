//
//  FavoriteCell.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 2.12.2022.
//

import UIKit
import SDWebImage

protocol FavoriteCellDelegate {
    func didTapDeleteButton(model: FavoriteNews.Fetch.ViewModel.Favorites?)
    func overlayViewOpen()
}

class FavoriteCell: UITableViewCell {

    static var identifier: String {
        get {
            "FavoriteCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "FavoriteCell", bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favDateLabel: UILabel!
    @IBOutlet weak var favTitleLabel: UILabel!
    @IBOutlet weak var favSourceNameLabel: UILabel!
    
    var favorites: FavoriteNews.Fetch.ViewModel.Favorites?
    var delegate: FavoriteCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favImageView.round(15)
        favImageView.layer.masksToBounds = true
        backView.round(1)
        backView.addBorder(color: .secondarySystemGroupedBackground, width: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.overlayViewOpen()
        
    }
    
    func configureFavorite(data: FavoriteNews.Fetch.ViewModel.Favorites, delegate: FavoriteCellDelegate ) {
        favTitleLabel.text = data.title
        favDateLabel.text = data.publishedAt
        favDateLabel.text = Date.formattedDateFromString(dateString: data.publishedAt ?? "")
        favSourceNameLabel.text = data.name
        
        if let image = data.urlToImage {
            favImageView.sd_setImage(with: URL(string: image ))

        } else {
            let defaultImage = UIImage(named: "us.news")
            favImageView.image = defaultImage
        }

        self.delegate = delegate
     }
}
