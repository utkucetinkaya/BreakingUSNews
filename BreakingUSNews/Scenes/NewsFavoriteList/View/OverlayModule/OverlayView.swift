//
//  OverlayView.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 13.12.2022.
//

import UIKit

class OverlayView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var viewModel: NewsList.Fetch.ViewModel?
    @IBOutlet weak var slideIdicator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIdicator.roundCorners(.allCorners, radius: 10)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        CoreDataManager.shared.deleteFavorites(model: NewsList.Fetch.ViewModel.News?) { result in
                    switch result {
                    case.success():
                        print("deleted from the database")
                    case.failure(let error):
                        print(error.localizedDescription)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
