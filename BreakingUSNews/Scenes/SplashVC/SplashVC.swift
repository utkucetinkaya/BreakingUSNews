//
//  SplashVC.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 12.12.2022.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

    var window: UIWindow?
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "onboarding")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        
        animationView!.play()
        splashVCConfigure()
    }
   
    func splashVCConfigure(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            let storyBoard = UIStoryboard(name: "NewsList", bundle: nil)
            let destVC: NewsListViewController = storyBoard.instantiateViewController(identifier: "NewsList")

            self.navigationController?.setViewControllers([destVC], animated: true)
        }
    }
}
