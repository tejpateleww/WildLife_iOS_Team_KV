//
//  Colors.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

import Foundation
import  UIKit

enum colors{
    case white,black,appColor,red,btnColor,tableBg,gradient1,gradient2,lightGrey,coresoundThemeColor
    
    var value:UIColor{
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .appColor:
            return UIColor(hexString:"#7357ee")
        //return UIColor(red: 134/255, green: 65/255, blue: 224/255, alpha: 1.0)
        case .btnColor:
            return UIColor(red: 95/255, green: 91/255, blue: 238/255, alpha: 1.0)
        case .red:
            return UIColor.red
        case .tableBg:
            return UIColor(hexString: "#252525")
        case .gradient1:
            return UIColor(hexString: "#736DFF")
        case .gradient2:
            return UIColor(hexString: "#7C3FE1")
        case .coresoundThemeColor:
            return UIColor(hexString: "#111044")
        case .lightGrey:
            return UIColor(hexString: "#666666")
        }
    }
}
