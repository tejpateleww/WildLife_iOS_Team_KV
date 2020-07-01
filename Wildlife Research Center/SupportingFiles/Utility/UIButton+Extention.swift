//
//  UIButton+Extention.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit


class ThemeButton : UIButton{
        
    @IBInspectable public var isGrayButton: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.cornerRadius = 5.0
        
        if isGrayButton {
            self.backgroundColor = .appColor(.grayText)
//            var shadowLayer: CAShapeLayer!
//            if shadowLayer == nil {
//                self.layoutIfNeeded()
//                shadowLayer = CAShapeLayer()
//                shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
//                shadowLayer.fillColor = UIColor.appColor(.grayText).cgColor
//                shadowLayer.shadowColor = UIColor.gray.cgColor
//                shadowLayer.shadowPath = shadowLayer.path
//                shadowLayer.shadowOffset = CGSize(width: 1, height: 1)
//                shadowLayer.shadowOpacity = 0.3//0.18
//                shadowLayer.shadowRadius = 6.0//2.0
//                self.layer.insertSublayer(shadowLayer, at: 0)
//                //self.layer.addSublayer(shadowLayer)
//                self.clipsToBounds = false
//                //layer.insertSublayer(shadowLayer, below: nil) // also works
//            }
        } else {
//            gredientColor(myView: self, topColor: .appColor(.buttonTop), bottomColor: .appColor(.buttonBottom))
            self.layoutIfNeeded()
            self.backgroundColor = .appColor(.buttonBottom)
        }
        
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setup()
    }
    
    func setup() {
    }
    
    
}

// Bhavesh Code :

//self.cornerRadius = 5.0
//if isGrayButton {
//    self.backgroundColor = .appColor(.grayText)
//    var shadowLayer: CAShapeLayer!
//    if shadowLayer == nil {
//        self.layoutIfNeeded()
//        shadowLayer = CAShapeLayer()
//        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
//        shadowLayer.fillColor = UIColor.appColor(.grayText).cgColor
//        shadowLayer.shadowColor = UIColor.gray.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 1, height: 1)
//        shadowLayer.shadowOpacity = 0.3//0.18
//        shadowLayer.shadowRadius = 6.0//2.0
//        self.layer.insertSublayer(shadowLayer, at: 0)
//        //self.layer.addSublayer(shadowLayer)
//        self.clipsToBounds = false
//        //layer.insertSublayer(shadowLayer, below: nil) // also works
//    }
//} else {
//    gredientColor(myView: self, topColor: .appColor(.buttonTop), bottomColor: .appColor(.buttonBottom))


