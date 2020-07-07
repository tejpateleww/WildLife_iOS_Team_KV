//
//  WebServiceSubClass.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit

class WebServiceSubClass{
    
    class func initApi( strParams : String ,showHud : Bool = true ,completion: @escaping CompletionResponse ) {
        WebService.shared.getMethod(api: .Init, parameterString: strParams, httpMethod: .get,showHud: showHud, completion: completion)
    }
    
    class func loginApi( userName: String, passWord: String, showHud: Bool = true, completion: @escaping CompletionResponse) {
        WebService.shared.getMethod(api: .login, parameterString: "juser=\(userName)&jpass=\(passWord)" , httpMethod: .get, showHud: showHud, completion: completion)
    }
    
    class func storeStateCityListsApi( showhud: Bool, completion : @escaping CompletionResponse) {
        WebService.shared.getMethod(api: .StoreStateAndCityList, parameterString: "", httpMethod: .get, showHud: showhud, completion: completion)
    }
    
    class func addStoreManually( store: String, state: String, city: String, showhud: Bool = true, completion: @escaping CompletionResponse) {
        WebService.shared.getMethod(api: .AddStoreManually, parameterString: "title=\(store)&state=\(state)&city=\(city)".replaceCharacter(oldCharacter: " ", newCharacter: ""), httpMethod: .get, showHud: showhud, completion: completion)
    }
    
    class func storeListForStatesAPI( title: String, state: String, showhud: Bool = false, completion: @escaping CompletionResponse) {
        
        let title1 = title.replaceCharacter(oldCharacter: "&", newCharacter: "%26")
        let str = "title=\(title1)&state=\(state)".replaceCharacter(oldCharacter: " ", newCharacter: "%20")
        
        WebService.shared.getMethod(api: .StoreListForStates, parameterString: str , httpMethod: .get, showHud: showhud, completion: completion)
    }
    
    class func imageUploadAPI( image: UIImage, showhud: Bool = false, completion: @escaping CompletionResponse) {
        
        let param = ["fileToUpload" : ""]
        
        WebService.shared.postDataWithImage(api: .imageUpload, showHud: showhud, parameter: param, image: image, imageParamName: "fileToUpload", completion: completion)
        
    }
    
    class func submit( params: Any, showhud: Bool = true, completion : @escaping CompletionResponse) {
        
        WebService.shared.requestMethod(api: .SubmitReports, httpMethod: .post, showHud: showhud, parameters: params, completion: completion)
    }
    
    class func mapDealers( showhud: Bool = true, completion : @escaping CompletionResponse ) {
        WebService.shared.getMethod(api: .mapDealers, parameterString: "", httpMethod: .get, showHud: showhud, completion: completion)
    }
    
    
}
