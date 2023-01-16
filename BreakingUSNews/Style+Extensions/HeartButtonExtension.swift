//
//  HeartButtonExtension.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 16.01.2023.
//

import Foundation
import UIKit

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
    layer.add(pulse, forKey: nil)
    }
}
