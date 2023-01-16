//
//  FavoriteVC+TableView.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 2.12.2022.
//

import Foundation
import UIKit
import CoreData

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
        cell.selection = {
            self.showMiracle(indexPath: indexPath, model: model)
        }
        cell.configureFavorite(data: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        router?.routeToFavoriteDetail(index: indexPath.row)
    }

    @objc func showMiracle(indexPath: IndexPath, model: FavoriteItem) {
        let slideVC = OverlayView()
        slideVC.selection = {
            self.viewModel?.favorites.remove(at: indexPath.row)
            self.favoriteTableView.reloadData()
            CoreDataManager.shared.deleteFavorites(model: model) { result in
                switch result {
                case.success():
                    print("deleted from the database")
                    self.dismiss(animated: false)
                    self.interactor?.fetchFavorites(request: FavoriteNews.Fetch.Request.init())

                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
}

extension NewsFavoriteListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
