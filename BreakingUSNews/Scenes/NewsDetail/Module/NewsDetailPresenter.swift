//
//  NewsDetailPresenter.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 17.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsDetailPresentationLogic: AnyObject {
    func presentArticle(response: NewsDetail.Fetch.Response)
    func presentAlert(error: Error)
}

final class NewsDetailPresenter: NewsDetailPresentationLogic {
    weak var viewController: NewsDetailsDisplayLogic?
    
    func presentArticle(response: NewsDetail.Fetch.Response) {
        
        viewController?.displayNews(viewModel: NewsDetail.Fetch.ViewModel(title: response.articles.title,
                                                                          urlToImage: response.articles.urlToImage,
                                                                          publishedAt: response.articles.publishedAt,
                                                                          name: response.articles.source?.name,
                                                                          content: response.articles.content ?? "",
                                                                          description: response.articles.articleDescription ?? "",
                                                                          url: response.articles.url))
    }
    
    func presentAlert(error: Error) {
    }
}
