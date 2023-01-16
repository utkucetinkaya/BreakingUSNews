//
//  NewsListViewController.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 12.11.2022.
//

import UIKit
import ToastPresenter
import CoreData
import RxCocoa
import RxSwift

protocol GetNewsDataProtocol: AnyObject {
    func getNewsData(viewModel: NewsList.Fetch.ViewModel)
}

class NewsListViewController: UIViewController {

    // MARK: - Properties
    let disposeBag = DisposeBag()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewModel: NewsList.Fetch.ViewModel?
    var interactor: GetNewsListInteracting?
    var router: (NewsRoutingLogic & NewsDataPassing)?
 
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newsCountLabel: UILabel!
    
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
        observeFavoriteCount()
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        tableView.reloadData()
    }
    @IBAction func didTapFavoriteListButton(_ sender: Any) {
        router?.routeToFavoriteList()
    }
  
    // MARK: - Function
    
    func observeFavoriteCount() {
        let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        request.shouldRefreshRefetchedObjects = true

        let people = try! context.fetch(request)
    
        Observable.just(people)
            .map {"Number of favorite news: \($0.count)" }
            .bind(to: newsCountLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func configView() {
        
        self.title = "Breaking US News"
        self.view.backgroundColor = .systemBackground
        setupTableView()
    }
}

extension NewsListViewController: NewsCellDelegate {
    func didTapDeleteFavoriteButton(indexPath: IndexPath, model: FavoriteItem) {
        self.viewModel?.articles.remove(at: indexPath.row)
        self.tableView.reloadData()
        CoreDataManager.shared.deleteFavorites(model: model) { result in
            switch result {
            case.success():
                print("deleted from the database")
                self.dismiss(animated: false)

            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    func didTapFavoriteButton(model: NewsList.Fetch.ViewModel.News?) {
        
        if let article = model {
            CoreDataManager.shared.favoriteNewsList(model: article) { result in
                switch result {
                case.success():
                    print("success")
                    self.observeFavoriteCount()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func toastMessage() {
        ToastView(message: "Saved to favorites!", font: .preferredFont(forTextStyle: .headline))
            .setImage(UIImage(named: "tick"))
            .setTextColor(.darkText)
            .setBackgroundColor(.white, alpha: 0.5)
            .show(in: view, position: .top(constant: 20), holdingTime: 2, fadeAnimationDuration: 1)
    }
}

extension NewsListViewController: GetNewsDataProtocol {
    
    func getNewsData(viewModel: NewsList.Fetch.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}
