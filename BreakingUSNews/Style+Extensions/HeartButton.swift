//
//  HeartButton.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 21.11.2022.
//

import Foundation
import UIKit
//
extension UIButton {
    
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.4
    pulse.fromValue = 0.3
    pulse.toValue = 1.0
    pulse.autoreverses = true
    pulse.repeatCount = .zero
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    likeButton.layer.add(pulse, forKey: nil)
    }
}


