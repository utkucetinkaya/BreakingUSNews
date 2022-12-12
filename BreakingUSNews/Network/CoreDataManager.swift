//
//  CoreDataManager.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 25.11.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }

    static let shared = CoreDataManager()
    
    func favoriteNewsList(model: NewsList.Fetch.ViewModel.News, completion: @escaping(Result<Void, Error>) -> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext
        
        let item = FavoriteItem(context: context)
        
        
        item.publishedAt = model.publishedAt
        item.name = model.name
        item.title = model.title
        item.urlToImage = model.urlToImage
        item.desc = model.description
        item.content = model.content
        item.url = model.url
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }

    func fetchingFavoritesFromDataBase(completion: @escaping(Result<[FavoriteItem], Error>) -> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteItem>
        let item = FavoriteItem(context: context)

        request = FavoriteItem.fetchRequest()

        do {
            let favorites = try context.fetch(request)
            completion(.success(favorites))

        }catch { completion(.failure(DatabaseError.failedToFetchData))
        }
    }

    func deleteFavorites(model: FavoriteItem, completion: @escaping (Result<Void, Error>) -> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext

        context.delete(model)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
