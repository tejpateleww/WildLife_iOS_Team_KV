//
//  DatabaseHandler.swift
//  Wildlife Research Center
//
//  Created by EWW074 - Sj's iMAC on 01/07/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import CoreData


class DataBaseHandler {
    
    static let sharedManager = DataBaseHandler()
    
    private init() {}
    
    lazy var persistentContainer : NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WildlifeResearchCenter")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
        
    }()
    
    func saveContext () {
        let context = DataBaseHandler.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //MARK:- User functions
    func fetchAllUserData(entityName:String) -> [NSManagedObject]? {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let allData = try managedContext.fetch(fetchRequest)
            return allData
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    
    
    func fetchCurrentUserData() -> NSManagedObject? {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
//        fetchRequest.predicate = NSPredicate(format: "isCurrentUser == true", "isCurrentUser")
        
        do {
            let allData = try managedContext.fetch(fetchRequest)
            return allData.first
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
        
    }
    
    
    // Called when Login api call is Successful
    func saveCurrentUserInDB() {
        
        let userDetails = SingletonClass.sharedInstance.LoginRegisterUpdateData!
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let SingleUser = NSManagedObject(entity: entity,insertInto: managedContext)
        guard let selectedSingleUser = userDetails.data else {return}
        
        SingleUser.setValue(selectedSingleUser.username, forKeyPath: "username")
        SingleUser.setValue(selectedSingleUser.password, forKeyPath: "password")
        SingleUser.setValue(selectedSingleUser.num, forKeyPath: "num")
        SingleUser.setValue(selectedSingleUser.createdDate, forKeyPath: "createdDate")
        SingleUser.setValue(selectedSingleUser.dragSortOrder, forKeyPath: "dragSortOrder")
        SingleUser.setValue(selectedSingleUser.full_name, forKeyPath: "full_name")
        SingleUser.setValue(selectedSingleUser.rep_group, forKeyPath: "rep_group")
        SingleUser.setValue(selectedSingleUser.email_address, forKeyPath: "email_address")
        SingleUser.setValue(selectedSingleUser.updatedDate, forKeyPath: "updatedDate")
        SingleUser.setValue(selectedSingleUser.createdByUserNum, forKeyPath: "createdByUserNum")
        SingleUser.setValue(true, forKeyPath: "isCurrentUser")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func update(isCurrentUser:String, user : User) {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        
        do {
            user.setValue(isCurrentUser, forKey: "isCurrentUser")
            
            do {
                try managedContext.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    
    //MARK:- Map Dealer Functions
    func saveMapDealerData(modal: MapDealerData) {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Mapdealers", in: managedContext)!
        let SingleDealer = NSManagedObject(entity: entity,insertInto: managedContext)
        
        
        //        guard let modal = userDetails.data else {return}
        
        SingleDealer.setValue(modal.num, forKeyPath: "num")
        SingleDealer.setValue(modal.createdDate, forKeyPath: "createdDate")
        SingleDealer.setValue(modal.createdByUserNum, forKeyPath: "createdByUserNum")
        SingleDealer.setValue(modal.updatedDate, forKeyPath: "updatedDate")
        SingleDealer.setValue(modal.updatedByUserNum, forKeyPath: "updatedByUserNum")
        SingleDealer.setValue(modal.dragSortOrder, forKeyPath: "dragSortOrder")
        SingleDealer.setValue(modal.title, forKeyPath: "title")
        SingleDealer.setValue(modal.address, forKeyPath: "address")
        SingleDealer.setValue(modal.city, forKeyPath: "city")
        SingleDealer.setValue(modal.state, forKeyPath: "state")
        SingleDealer.setValue(modal.zip, forKeyPath: "zip")
        SingleDealer.setValue(modal.phone, forKeyPath: "phone")
        SingleDealer.setValue(modal.website, forKeyPath: "website")
        SingleDealer.setValue(modal.latitude, forKeyPath: "latitude")
        SingleDealer.setValue(modal.longitude, forKeyPath: "longitude")
        SingleDealer.setValue(modal.store, forKeyPath: "store")
        
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }
    
    
    func deleteMapDealerData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Mapdealers")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func deleteStateListData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Statenames")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func deleteStoreListData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Storenames")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func deleteCityListData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Citynames")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    
    
    
    
    // Store - State - City Names Functions ( for Select Store screen)
    
    func saveCityNames(str : String) {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Citynames", in: managedContext)!
        let SingleCityName = NSManagedObject(entity: entity,insertInto: managedContext)
        
        SingleCityName.setValue(str, forKeyPath: "name")
        
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }
    
    
    func saveStateNames(str: String) {
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Statenames", in: managedContext)!
        let SingleStateName = NSManagedObject(entity: entity,insertInto: managedContext)
        
        SingleStateName.setValue(str, forKeyPath: "name")
        
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }
    
    func saveStoreNames(str: String) {
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Storenames", in: managedContext)!
        let SingleStoreName = NSManagedObject(entity: entity,insertInto: managedContext)
        
        SingleStoreName.setValue(str, forKeyPath: "name")
        
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }
    
    
    
    func fetchAlllists(entityName:String) -> [NSManagedObject]? {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let allData = try managedContext.fetch(fetchRequest)
            return allData
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func fetchListBasedOnPredicate (state: String, store: String) -> [NSManagedObject]? {
        
        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Mapdealers")

        let predicate1 = NSPredicate(format: "state = %@", state as CVarArg)
        let predicate2 = NSPredicate(format: "title = %@", store as CVarArg)
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2])
        
        do {
            let allData = try managedContext.fetch(fetchRequest)
            return allData

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
        
    }
    
}





//
//    func updateCurrentUserInDB() {
//
//        let managedContext = DataBaseHandler.sharedManager.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
//        let SingleUser = NSManagedObject(entity: entity,insertInto: managedContext)
////        guard let selectedSingleUser = userDetails.data else {return}
//
//        let fetchRequest =
//            NSFetchRequest<NSManagedObject>(entityName: "User")
//        let sort = NSSortDescriptor(key: "username", ascending: false)
//        fetchRequest.sortDescriptors = [sort]
//
//        //3
//        do {
//            let  langugeCodes = try managedContext.fetch(fetchRequest)
//            for result in langugeCodes as [NSManagedObject] {
//                var   username:String = result.value(forKey: "username")! as! String
//                var   password:String = result.value(forKey: "password")! as! String
//
//                print("username==>",username)
//                print("name==>",name)
//
//            }
//
//    }
