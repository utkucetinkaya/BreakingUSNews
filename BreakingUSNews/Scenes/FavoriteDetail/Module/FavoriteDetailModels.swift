//
//  FavoriteDetailModels.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 15.12.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum FavoriteDetail {
  
  enum Fetch {
    
      struct Request {
    }
      
    struct Response {
        var favItem: FavoriteItem
    }
      
    struct ViewModel {
        let title: String?
        let urlToImage: String?
        let publishedAt: String?
        let name: String?
        let content: String?
        let description: String?
        var url: String?
    }
  }
}