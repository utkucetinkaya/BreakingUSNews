//
//  NewsCell.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 15.11.2022.
//

import UIKit
import SDWebImage
import FirebaseAnalytics

protocol NewsCellDelegate {
    func didTapFavoriteButton(model: NewsList.Fetch.ViewModel.News?)
    func toastMessage()
    func didTapDeleteFavoriteButton(indexPath: IndexPath, model: FavoriteItem)
}
class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        get {
            "NewsCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "NewsCell", bundle: nil)
    }
    
    var isFavorited: Bool = false {
        didSet {
            if isFavorited {
                likeButton.setImage(UIImage(named: "heart_filled"), for: .normal)
                delegate?.didTapFavoriteButton(model: articles)
            } else {
                likeButton.setImage(UIImage(named: "heart_empty"), for: .normal)
            }
        }
    }
    var articles: NewsList.Fetch.ViewModel.News?
    var delegate : NewsCellDelegate?
    // MARK: - IBOulets
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.dropViewShadow()
        newsImageView.round(15)
        newsImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func heartButton(_ sender: UIButton) {

        isFavorited = !isFavorited
        likeButton.pulsate()

        analytics()
        delegate?.toastMessage()
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            newsImageView.image = nil
        }

    func analytics() {
        Analytics.logEvent("favorite_added" , parameters: [
            "favorite_title": articles?.title ?? ""] )
    }
        
    func configure(viewModel: NewsList.Fetch.ViewModel.News, delegate: NewsCellDelegate) {
            self.articles = viewModel
            titleLabel.text  = viewModel.title
            sourceNameLabel.text = viewModel.name
            publishedAtLabel.text = getPastTime(for: formattedDate(dateStr: viewModel.publishedAt ?? ""))
            
            if let image = viewModel.urlToImage {
                newsImageView.sd_setImage(with: URL(string: image ))
                
            } else {
                let defaultImage = UIImage(named: "default_news")
                newsImageView.image = defaultImage
            }
            self.delegate = delegate
    }
}
