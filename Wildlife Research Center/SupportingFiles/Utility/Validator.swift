//
//  Validator.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) -> (Bool,String)
}

enum ValidatorType {
    case email
    case password
//    case username
    case requiredField(field: String)
    case age
    
    case cardHolder
//    case cardNumber
    case expDate
    case cvv
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        //        case .username: return UserNameValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        case .cardHolder: return CardHolderValidator()
//        case .cardNumber: return CardNumberValidator()
        case .expDate: return ExpDateValidator()
        case .cvv: return CvvValidator()
        }
    }
}



class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) -> (Bool, String)
    {
        guard value.count > 0 else{return (false,ValidationError("Age is required").message)}
        guard let age = Int(value) else {return (false,ValidationError("Age must be a number!").message)}
        guard value.count < 3 else {return (false,ValidationError("Invalid age number!").message)}
        guard age >= 18 else {return (false,ValidationError("You have to be over 18 years old to user our app :)").message)}
        return (true, "")
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) -> (Bool, String) {
        guard !value.isEmpty else {
            return (false,ValidationError("Please enter " + fieldName).message)
        }
        return (true,"")
    }
}
/*
struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}
*/
struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String)  -> (Bool,String) {
        guard value != "" else {return (false,ValidationError("Password is Required").message)}
        guard value.count >= 8 else { return (false,ValidationError("Password must have at least 8 characters").message) }
        
//        do {
//            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                return (false,ValidationError("Password must be more than 6 characters, with at least one character and one numeric character").message)
//            }
//        } catch {
//            return (false,ValidationError("Password must be more than 6 characters, with at least one character and one numeric character").message)
//        }
        return (true, "")
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String)  -> (Bool,String) {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                return (false,ValidationError("Invalid e-mail Address").message)
            }
        } catch {
            return (false,ValidationError("Invalid e-mail Address").message)
        }
        return (true, "")
    }
}

struct CardHolderValidator: ValidatorConvertible {
    func validated(_ value: String) -> (Bool, String) {
        guard value != "" else {return (false,ValidationError("Please enter card holder name").message)}

        return (true, "")
    }
}

//struct CardNumberValidator: ValidatorConvertible {
//    func validated(_ value: String) -> (Bool, String) {
//        guard value != "" else {return (false, ValidationError("Please enter card number").message)}
//        guard value.count >= 19 else { return (false, ValidationError("Card number must have at least 16 characters").message )}
//        let v = CreditCardValidator()
//        guard v.validate(string: value) else { return (false, ValidationError("Card number is invalid").message) }
//
//        return (true, "")
//    }
//}

struct CvvValidator: ValidatorConvertible {
    func validated(_ value: String) -> (Bool, String) {
        guard value != "" else {return (false, ValidationError("Please enter CVV").message)}
        guard value.count >= 3 && value.count < 5 else { return (false, ValidationError("Please enter valid CVV number").message) }
        return (true,"")
    }
}

struct ExpDateValidator: ValidatorConvertible {
    func validated(_ value: String) -> (Bool, String) {
        guard value != "" else { return (false, ValidationError("Please enter expiry date").message)}
        guard expDateValidation(dateStr: value) else {  return (false, ValidationError("Invalid expiry date").message) }
        return (true, "")
    }
    
    func expDateValidation(dateStr:String) -> Bool {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enterdYr = Int(dateStr.suffix(2)) ?? 0   // get last two digit from entered string as year
        let enterdMonth = Int(dateStr.prefix(2)) ?? 0  // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user

        if enterdYr > currentYear{
            if (1 ... 12).contains(enterdMonth){
                return true
            } else{
                return false
            }
        } else  if currentYear == enterdYr {
            if enterdMonth >= currentMonth{
                if (1 ... 12).contains(enterdMonth) {
                    return true
                } else{
                    return false
                }
            } else {
                return false
            }
        } else {
            return true
        }
    }
}

