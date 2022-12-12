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

}
class NewsCell: UITableViewCell {

    
    static var identifier: String {
        get {
            "NewsCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "NewsCell", bundle: nil)
    }
    // MARK: - IBOulets
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var articles: NewsList.Fetch.ViewModel.News?
    var delegate : NewsCellDelegate?
  
    
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
        
        likeButton.isSelected = !likeButton.isSelected
        if likeButton.isSelected == true {
            delegate?.didTapFavoriteButton(model: articles)
        } else {
            return
        }
        pulsate()
        configureUIButton()
        analytics()
    }

    func analytics() {
        Analytics.logEvent("favorite_added" , parameters: [
            "favorite_title": articles?.title ?? ""] )
    }
   
    
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.4
    pulse.fromValue = 0.3
    pulse.toValue = 1.0
    pulse.autoreverses = true
    pulse.repeatCount = .zero
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    likeButton.layer.add(pulse, forKey: nil)
    }
    
    func configureUIButton() {
        let imageFilled = UIImage(named: "heart_filled")
        let imageEmpty = UIImage(named: "heart_empty")
        likeButton.setImage(imageEmpty, for: .normal)
        likeButton.setImage(imageFilled, for: .selected)
    }

    
    func configure(viewModel: NewsList.Fetch.ViewModel.News, delegate: NewsCellDelegate) {
        self.articles = viewModel
        titleLabel.text  = viewModel.title
        sourceNameLabel.text = viewModel.name
        publishedAtLabel.text = getPastTime(for: formattedDate(dateStr: viewModel.publishedAt ?? ""))
        
        if let image = viewModel.urlToImage {
            newsImageView.sd_setImage(with: URL(string: image ))

        } else {
            let defaultImage = UIImage(named: "us.news")
            newsImageView.image = defaultImage
        }
        
        self.delegate = delegate
    }
}
