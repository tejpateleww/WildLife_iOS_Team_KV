//
//  Constant.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 22/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit


let keywindow = UIApplication.shared.keyWindow
let appDel = UIApplication.shared.delegate as! AppDelegate



enum themeColor: String {
    case backgroundGray = "FDFDFD"
    case Navigation = "fbc210"
    case grayText = "818181"
    case textColor = "000000"
    case buttonBottom = "FBC110"
    case buttonTop = "F7D309"
    case grayView = "e2e2e2"
    case highlitedGreen = "5C9540"
}


//Aileron


enum FontSize : CGFloat {
    
    case size8 = 8.0
    case size10 = 10.0
    case size12 = 12.0
    case size13 = 13.0
    case size14 = 14.0
    case size15 = 15.0
    case size16 = 16.0
    case size17 = 17.0
    case size18 = 18.0
    case size20 = 20.0
    case size22 = 22.0
    case size24 = 24.0
}


enum FontBook: String {
    
    case AileronBlack =  "Aileron-Black"
    case AileronBold = "Aileron-Bold"
    case AileronBlackItalic = "Aileron-BlackItalic"
    case AileronBoldItalic = "Aileron-BoldItalic"
    case AileronItalic = "Aileron-Italic"
    case AileronRegular = "Aileron-Regular"
    case AileronThin = "Aileron-Thin"
    case AileronThinItalic = "Aileron-ThinItalic"
    case AileronLight = "Aileron-Light"
    case AileronLighttalic = "Aileron-LightItalic"
    
    func of(size: CGFloat) -> UIFont {
//        return UIFont(name:self.rawValue, size: manageFont(font: size))!
        return UIFont(name:self.rawValue, size: size)!
    }
    
    func manageFont(font : CGFloat) -> CGFloat {
        let cal  = SCREEN_HEIGHT * font
        return CGFloat(cal / CGFloat(screenHeightDeveloper))
    }
    func staticFont(size : CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
   func setlabelFont(labels:[UILabel] , Size:CGFloat , TextColour:UIColor) {
        for label in labels{
            label.font = staticFont(size: Size)
            label.textColor = TextColour
        }
    }
}


let screenHeightDeveloper : Double = 667 //568
let screenWidthDeveloper : Double = 375 //320
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)


func gredientColor(myView: UIView, topColor: UIColor, bottomColor: UIColor) {
    
    myView.layoutIfNeeded()
    myView.backgroundColor = bottomColor
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = myView.bounds
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.cornerRadius = 5
//    myView.layer.addSublayer(gradientLayer)
    myView.layer.insertSublayer(gradientLayer, at: 0)
    
    myView.layoutIfNeeded()
}


enum AssetsColor {
   case backgroundGray
   case Navigation
   case grayText
   case textColor
   case buttonBottom
   case buttonTop
   case grayView
   case highlitedGreen
}

extension UIColor {

    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .backgroundGray:
            return UIColor(named: "backgroundGray") ?? UIColor.black
        case .Navigation:
            return UIColor(named: "Navigation") ?? UIColor.black
        case .grayText:
            return UIColor(named: "grayText") ?? UIColor.black
        case .textColor:
            return UIColor(named: "textColor") ?? UIColor.black
        case .buttonBottom:
            return UIColor(named: "buttonBottom") ?? UIColor.red
        case .buttonTop:
            return UIColor(named: "buttonTop") ?? UIColor.black
        case .grayView:
            return UIColor(named: "grayView") ?? UIColor.black
        case .highlitedGreen:
            return UIColor(named: "highlitedGreen") ?? UIColor.black
        }
    }
}
