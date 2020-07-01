//
//  UITextField+Extention.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 23/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!, NSAttributedString.Key.font: UIFont(name:FontBook.AileronRegular.rawValue, size:FontSize.size17.rawValue)!])
        }
    }
    
    func validatedText(validationType: ValidatorType) -> (Bool,String) {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return validator.validated(self.text!)
    }
    
}
