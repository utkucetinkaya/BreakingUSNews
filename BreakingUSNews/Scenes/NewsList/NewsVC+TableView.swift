//
//  NewsVC+TableView.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 16.11.2022.
//

import Foundation
import UIKit

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        registerCells()
    }
    
    func registerCells() {
        tableView.register(NewsCell.register(), forCellReuseIdentifier: NewsCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        guard let model = viewModel?.articles[indexPath.row] else {
            return UITableViewCell()
        }
        cell.addTapGesture { [self] in
            router?.routeToNewsDetail(index: indexPath.row)
        }
        cell.configure(viewModel: model, delegate: self)
        cell.articles = model
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 100, 0)
                cell.layer.transform = rotationTransform
                cell.alpha = 0.2
                
                UIView.animate(withDuration: 0.75) {
                    cell.layer.transform = CATransform3DIdentity
                    cell.alpha = 1.0
        }
    }
}

extension NewsListViewController: NewsCellDelegate {
    

    func didTapFavoriteButton(model: NewsList.Fetch.ViewModel.News?) {
        
        if let article = model {
            CoreDataManager.shared.favoriteNewsList(model: article) { result in
                switch result {
                case.success():
//                    NotificationCenter.default.post(name: NSNotification.Name("Added to Favorite List" ), object: nil)
                    print("success")
                    
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

