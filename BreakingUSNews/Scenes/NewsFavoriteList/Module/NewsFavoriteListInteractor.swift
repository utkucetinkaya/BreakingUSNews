//
//  NewsFavoriteListInteractor.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 23.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GetFavoriteListInteracting: AnyObject {
    func fetchFavorites(request: FavoriteNews.Fetch.Request)
}
protocol FavoriteListDataStore: AnyObject {
    var favorites: [FavoriteNews.Fetch.ViewModel.Favorites]? { get set}
}

class NewsFavoriteListInteractor: GetFavoriteListInteracting, FavoriteListDataStore {
    var favorites: [FavoriteNews.Fetch.ViewModel.Favorites]?
    
    
    var presenter: FavoriteNewsPresentationLogic?
    var worker: FavoriteNewsWorkingLogic?
    
    init(worker:FavoriteNewsWorkingLogic?) {
        self.worker = worker
    }
    
    func fetchFavorites(request: FavoriteNews.Fetch.Request) {
        
        worker?.fetchFavoriteNews(completion: { result in
            switch result {
            case.success(let fav):
                var favorites: [FavoriteNews.Fetch.ViewModel.Favorites] = []
                    fav.forEach {
                        if $0.title != nil {
                            favorites.append(FavoriteNews.Fetch.ViewModel.Favorites(title: $0.title,
                                           urlToImage: $0.urlToImage,
                                           publishedAt: $0.publishedAt,
                                            name: $0.name,
                                            content: $0.content,
                                           description: $0.desc))
                        }
                    }
                self.favorites = favorites
                self.presenter?.presentFavoriteNews(response: FavoriteNews.Fetch.Response(favorites: fav))
            case .failure(let error):
                self.presenter?.presentAler(error: error)
            }
        })
    }
}
