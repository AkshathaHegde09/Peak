//
//  Property.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import Foundation

//backendless to access in swift 4
@objcMembers

class Property : NSObject {
    
    var objectId: String?
    var referenceCode: String?
    var ownerId: String?
    var title: String?
    var numberOfRooms: Int = 0
    var numberOfBathrooms: Int = 0
    var size: Double = 0.0
    var balconySize: Double = 0.0
    var parking: Int = 0
    var floor: Int = 0
    var address: String?
    var city: String?
    var country: String?
    var propertyDescription: String?
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var adType: String?
    var availableFrom: String?
    var imageLink: String?
    var buildYear: String?
    var price: Int = 0
    var propertyType: String?
    var titleDeeds: Bool = false
    var centralHeating: Bool = false
    var waterHeating: Bool = false
    var ac: Bool = false
    var storeRoom: Bool = false
    var isFurnished: Bool = false
    var isSold: Bool = false
    var inTopUntil: Date?
    
    
    //MARK: SAVE FUNCTIONS
    
    //save property in backendless
    func saveProperty() {
        
        let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.save(self)
        
    }
    
    func saveProperty(completion: @escaping (_ value: String)-> Void) {
        
        let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.save(self, response: { (result) in
            completion("Success")
            
        }) { (fault: Fault?) in
            completion(fault!.message)
        }
        
    }
    
    //MARK: DELETE FUNCTIONS
    
    func deleteProperty(property: Property){
        
    let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.remove(property)
        
    }
    
    func deleteProperty(property: Property, completion: @escaping(_ value : String)-> Void){
        
        let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.remove(property,response: {(result) in
            completion("Success")
        }) { (fault: Fault?) in
            completion(fault!.message)
        }
    }
    
    //MARK: SEARCH FUNCTIONS
    
    // search for recent tab
    class func fetchRecentProperty(limitNumber: Int, completion: @escaping(_ properties: [Property?])-> Void) {
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setSortBy(["inTopUntill DESC"])
        queryBuilder?.setPageSize(Int32(limitNumber))
        queryBuilder?.setOffset(0)// always begin from top
        
        let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.find(queryBuilder, response: {(backendlessProperties) in
        
            completion(backendlessProperties as! [Property])
            
       }) { (fault: Fault?) in
           print("Error: couldnot get properties \(fault!.message)")
        completion([])
    }
    
    }
    
    //search all properties
    class func fetchAllProperties(completion: @escaping(_ properties: [Property?])-> Void) {
        let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.find({allProperties in
            
            completion(allProperties as! [Property])
            
        }) { (fault: Fault?) in
            print("Error: couldnot get properties \(fault!.message)")
            completion([])
        }
}
    
    class func fetchPropertiesWith(whereClause: String,completion: @escaping(_ properties: [Property?])-> Void) {
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause(whereClause)
        queryBuilder!.setSortBy(["inTopUntill DESC"])
        
        let dataStore = backendless!.data.of(Property().ofClass())
        dataStore!.find(queryBuilder, response: {(allProperties) in
            
            completion(allProperties as! [Property])
            
        }) { (fault: Fault?) in
            print("Error: couldnot get properties \(fault!.message)")
            completion([])
        }
    }
    
}
