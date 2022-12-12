//
//  SplashVC.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 12.12.2022.
//

import UIKit

class SplashVC: UIViewController {

    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vc = NewsListViewController(nibName: "NewsListViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: vc)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
        }
    }
}
