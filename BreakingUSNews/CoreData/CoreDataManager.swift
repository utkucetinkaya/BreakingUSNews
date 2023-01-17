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
        item.webUrl = model.url
        
        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        let favoriteNewsItems = try? context.fetch(fetchRequest)
        let newsItemCount = favoriteNewsItems?.count ?? 0
        
        if newsItemCount == 0 {
            item.order = 1
        } else {
            let sortDescriptor = NSSortDescriptor(key: "order", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let favoriteNewsItems = try? context.fetch(fetchRequest)
            let lastOrder = favoriteNewsItems?.first?.order ?? 0
            item.order = lastOrder + 1
        }
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

        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let favoriteNewsItems = try? context.fetch(fetchRequest)
        do {
            let favorites = try context.fetch(fetchRequest)
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
