//
//  UIView+Extention.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 22/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit


final class CustomView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    @IBInspectable public var isRounded : Bool = false
//    @IBInspectable public var CornerRadius: CGFloat = 5.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        if shadowLayer == nil {
            self.layoutIfNeeded()
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: isRounded ? (self.frame.size.height/2) : cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 1, height: 1)
            shadowLayer.shadowOpacity = 0.3//0.18
            shadowLayer.shadowRadius = 6.0//2.0
            self.layer.insertSublayer(shadowLayer, at: 0)
            //self.layer.addSublayer(shadowLayer)
            self.clipsToBounds = false
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
}


extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
