//
//  SelectionButton.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 30/06/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SelectionButton: UIButton {
    
    // The text that's shown in each state
//    @IBInspectable var selectedText:String = "Selected"
//    @IBInspectable var deselectedText:String = "Deselected"
    
    // The color of text shown in each state
    @IBInspectable var textColorDeselected:UIColor = UIColor.white
    @IBInspectable var textColorSelected:UIColor = UIColor.white
    
    // Sets the Active/Inactive State
    @IBInspectable var active:Bool = false
    
    // Custom Border to the UIButton
    private let border = CAShapeLayer()

    override func draw(_ rect: CGRect) {
        
        
        self.backgroundColor = .appColor(.grayText)
        var shadowLayer: CAShapeLayer!
        if shadowLayer == nil {
            self.layoutIfNeeded()
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.appColor(.grayText).cgColor
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
        
        
        
        // Setup CAShape Layer (Dashed/Solid Border)
//        border.lineWidth = borderWidth
        border.frame = self.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(border)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        // Setup the Button Depending on What State it is in
        if active {
            setSelected()
        } else {
            setDeselected()
        }
        
        // Respond to touch events by user
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print("Button Pressed")
        active = !active
        
        if active {
            setSelected()
        } else {
            setDeselected()
        }
    }
    
    // Set the selected properties
    func setSelected() {
        border.lineDashPattern = nil
//        border.strokeColor = borderColorSelected.cgColor
//        self.setTitle(selectedText, for: .normal)
        self.setTitleColor(textColorSelected, for: .normal)
    }
    
    // Set the deselcted properties
    func setDeselected() {
        border.lineDashPattern = [4, 4]
//        border.strokeColor = borderColorDeselected.cgColor
//        self.setTitle(deselectedText, for: .normal)
        self.setTitleColor(textColorDeselected, for: .normal)
    }

}
