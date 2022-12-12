//
//  FavoriteVC+TableView.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 2.12.2022.
//

import Foundation
import UIKit

extension NewsFavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupFavoriteTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        registerFavoriteCells()
    }
    
    func registerFavoriteCells() {
        favoriteTableView.register(FavoriteCell.register(), forCellReuseIdentifier: FavoriteCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.favorites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell
        guard let model = viewModel?.favorites[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureFavorite(data: model, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        router?.routeToDetailNews(index: indexPath.row)

    }
}

extension NewsFavoriteListViewController: FavoriteCellDelegate {
    
    func didTapDeleteButton(model: FavoriteNews.Fetch.ViewModel.Favorites?) {
        
//        CoreDataManager.shared.deleteFavorites(model: viewModel?.favorites) { result in
//            switch result {
//            case.success():
//                print("deleted from the database")
//            case.failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

