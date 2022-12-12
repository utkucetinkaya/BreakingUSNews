//
//  Style.swift
//  BreakingUSNews
//
//  Created by Utku Çetinkaya on 9.12.2022.
//

import UIKit

// MARK: - View Properties

class ViewStyle: UIView {
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet{
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
}


// MARK: - Button Properties

class ButtonStyle: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet{
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
}
