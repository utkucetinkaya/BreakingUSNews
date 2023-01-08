//
//  NewsListModels.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 12.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


enum NewsList {
  enum Fetch {
      
    struct Request {
       
    }
      
    struct Response {
        var articles: [Article]
    }
      
    struct ViewModel {
        var articles: [NewsList.Fetch.ViewModel.News]
        
        struct News {
            let title: String?
            let urlToImage: String?
            let publishedAt: String?
            let name: String?
            let content: String?
            let description: String?
            let url: String?
            var isFavorited: Bool = false
      }
    }
  }
}
