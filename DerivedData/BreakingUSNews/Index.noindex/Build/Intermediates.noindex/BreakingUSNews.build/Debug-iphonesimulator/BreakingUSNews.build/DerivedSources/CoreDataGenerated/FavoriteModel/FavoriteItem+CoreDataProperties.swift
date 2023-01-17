//
//  FavoriteItem+CoreDataProperties.swift
//  
//
//  Created by Utku Çetinkaya on 11.01.2023.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FavoriteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteItem> {
        return NSFetchRequest<FavoriteItem>(entityName: "FavoriteItem")
    }

    @NSManaged public var content: String?
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var order: Int16
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var webUrl: String?

}

extension FavoriteItem : Identifiable {

}
