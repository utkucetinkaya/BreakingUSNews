//
//  NewsFavoriteListWorker.swift
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

protocol FavoriteNewsWorkingLogic: AnyObject {

    func fetchFavoriteNews(completion: @escaping ((Result<[FavoriteItem], Error>) -> Void))
}

final class NewsFavoriteListWorker: FavoriteNewsWorkingLogic {
     
    func fetchFavoriteNews(completion: @escaping ((Result<[FavoriteItem], Error>) -> Void)) {
        
        CoreDataManager.shared.fetchingFavoritesFromDataBase { result in
            
            switch result {
            case .success(let favorites):
                completion(.success(favorites))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}