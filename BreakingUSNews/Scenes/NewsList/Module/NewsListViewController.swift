//
//  NewsListViewController.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 12.11.2022.
//

import UIKit

protocol GetNewsDataProtocol: AnyObject {
    func getNewsData(viewModel: NewsList.Fetch.ViewModel)
}

class NewsListViewController: UIViewController {
    
    
    // MARK: - Variables
    

    var viewModel: NewsList.Fetch.ViewModel?
    var interactor: GetNewsListInteracting?
    var router: (NewsRoutingLogic & NewsDataPassing)?
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
  // MARK: - Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
    
  // MARK: - Setup
  
  private func setup() {
    let viewController = self
    let interactor = NewsListInteractor(worker: NewsListWorker())
    let presenter = NewsListPresenter()
    let router = NewsListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
      super.viewDidLoad()
        
        interactor?.fetchNews(request: NewsList.Fetch.Request.init())
        configView()
        
    }

    // MARK: - Function
    
    func configView() {
        
        self.title = "Breaking US News"
        self.view.backgroundColor = .systemBackground
        setupTableView()
    }
}

extension NewsListViewController: GetNewsDataProtocol {
    
    func getNewsData(viewModel: NewsList.Fetch.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}
