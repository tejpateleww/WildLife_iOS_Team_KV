//
//  ResProfileDatum.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import SwiftyJSON


class ResProfileDatum : NSObject, NSCoding{

    var num : String!
    var createdDate : String!
    var createdByUserNum : String!
    var updatedDate : String!
    var updatedByUserNum : String!
    var dragSortOrder : String!
    var username : String!
    var password : String!
    var full_name : String!
    var email_address : String!
    var rep_group : String!
    var _tableName : String!
    

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!) {
        if json.isEmpty{
            return
        }
        
        num = json["num"].stringValue
        createdDate = json["createdDate"].stringValue
        createdByUserNum = json["createdByUserNum"].stringValue
        updatedDate = json["updatedDate"].stringValue
        updatedByUserNum = json["updatedByUserNum"].stringValue
        dragSortOrder = json["dragSortOrder"].stringValue
        username = json["username"].stringValue
        password = json["password"].stringValue
        full_name = json["full_name"].stringValue
        email_address = json["email_address"].stringValue
        rep_group = json["rep_group"].stringValue
        _tableName = json["_tableName"].stringValue
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if num != nil{
            dictionary["num"] = num
        }
        if createdDate != nil{
            dictionary["createdDate"] = createdDate
        }
        if createdByUserNum != nil{
            dictionary["createdByUserNum"] = createdByUserNum
        }
        if updatedDate != nil{
            dictionary["updatedDate"] = updatedDate
        }
        if updatedByUserNum != nil{
            dictionary["updatedByUserNum"] = updatedByUserNum
        }
        if dragSortOrder != nil{
            dictionary["dragSortOrder"] = dragSortOrder
        }
        if username != nil{
            dictionary["username"] = username
        }
        if password != nil{
            dictionary["password"] = password
        }
        if full_name != nil{
            dictionary["full_name"] = full_name
        }
        if email_address != nil{
            dictionary["email_address"] = email_address
        }
        if rep_group != nil{
            dictionary["rep_group"] = rep_group
        }
        if _tableName != nil{
            dictionary["_tableName"] = _tableName
        }
        
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        num = aDecoder.decodeObject(forKey: "num") as? String
        createdDate = aDecoder.decodeObject(forKey: "createdDate") as? String
        createdByUserNum = aDecoder.decodeObject(forKey: "createdByUserNum") as? String
        updatedDate = aDecoder.decodeObject(forKey: "updatedDate") as? String
        updatedByUserNum = aDecoder.decodeObject(forKey: "updatedByUserNum") as? String
        dragSortOrder = aDecoder.decodeObject(forKey: "dragSortOrder") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        full_name = aDecoder.decodeObject(forKey: "full_name") as? String
        email_address = aDecoder.decodeObject(forKey: "email_address") as? String
        rep_group = aDecoder.decodeObject(forKey: "rep_group") as? String
        _tableName = aDecoder.decodeObject(forKey: "_tableName") as? String
        
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if num != nil{
            aCoder.encode(num, forKey: "num")
        }
        if createdDate != nil{
            aCoder.encode(createdDate, forKey: "createdDate")
        }
        if createdByUserNum != nil{
            aCoder.encode(createdByUserNum, forKey: "createdByUserNum")
        }
        if updatedDate != nil{
            aCoder.encode(updatedDate, forKey: "updatedDate")
        }
        if updatedByUserNum != nil{
            aCoder.encode(updatedByUserNum, forKey: "updatedByUserNum")
        }
        if dragSortOrder != nil{
            aCoder.encode(dragSortOrder, forKey: "dragSortOrder")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        if password != nil{
            aCoder.encode(password, forKey: "password")
        }
        if full_name != nil{
            aCoder.encode(full_name, forKey: "full_name")
        }
        if email_address != nil{
            aCoder.encode(email_address, forKey: "email_address")
        }
        if rep_group != nil{
            aCoder.encode(rep_group, forKey: "rep_group")
        }
        if _tableName != nil{
            aCoder.encode(_tableName, forKey: "_tableName")
        }
        
    }
}

