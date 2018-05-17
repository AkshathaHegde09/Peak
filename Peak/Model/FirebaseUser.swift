//
//  FirebaseUser.swift
//  Peak
//
//  Created by akshatha hegde on 5/15/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUser {
    
    //variable for user
    let objectId: String
    
    let createdAt: Date
    //user updated date
    var updatedAt: Date
    
    //currency for In-app purchase
    var coins:Int
    
    var companyName: String
    var firstName: String
    var lastName: String
    var fullName: String
    var avatar: String
    
    var isAgent: Bool
    //save id of favourite properties
    var favouriteProperties: [String]
    
    var phoneNumber: String
    var additionalPhoneNumber: String
    
    init(_objectId: String, _createdAt: Date, _updatedAt: Date, _firstName: String, _lastName: String, _avatar: String = "", _phoneNumber: String = "")
    {
        objectId = _objectId
        
        createdAt = _createdAt
        updatedAt = _updatedAt
        
        //10 coins by default to users
        coins = 10
        
        firstName = _firstName
        lastName = _lastName
        fullName = _firstName + _lastName
        avatar = _avatar
        isAgent = false
        companyName = ""
        favouriteProperties = []
        
        phoneNumber = _phoneNumber
        additionalPhoneNumber = ""
        
    }
    
    //to convert dictionary to user
    init(_dictionary: NSDictionary) {
        
        objectId = _dictionary[kOBJECTID] as! String
        
        //check if cretedAt date exist
        if let dicCreated = _dictionary[kCREATEDAT] {
            
            createdAt = dateFormatter().date(from: dicCreated as! String)!
            
        }
        else
        {
            
            createdAt = Date()
            
        }
        
        //check if updatedAt date exist
        if let dicUpdate = _dictionary[kUPDATEDAT] {
            
            updatedAt = dateFormatter().date(from: dicUpdate as! String)!
            
        }
        else
        {
            
            updatedAt = Date()
            
        }
        
        //check if coins exist
        if let dicCoins = _dictionary[kCOINS] {
            
            coins =  dicCoins as! Int
            
        }
        else
        {
            
            coins = 0
            
        }
        
        //check if company exist
        if let dicCompany = _dictionary[kCOMPANY] {
            
            companyName = dicCompany as! String
            
        }
        else
        {
            
            companyName = ""
            
        }
        
        //check if firstName exist
        if let  dicFirstName = _dictionary[kFIRSTNAME] {
            
            firstName = dicFirstName as! String
            
        }
        else
        {
            
            firstName = ""
            
        }
        
        //check if lastName exist
        if let dicLastName = _dictionary[kLASTNAME] {
            
            lastName = dicLastName as! String
            
        }
        else
        {
            
            lastName = ""
            
        }
        
        //check if fullName exist
        fullName = firstName + "" + lastName
        
        //check if avatar exist
        if let dicAvatar = _dictionary[kAVATAR] {
            
            avatar = dicAvatar as! String
            
        }
        else
        {
            
            avatar = ""
            
        }
        
        //check if agent exist
        if let dicAgent = _dictionary[kISAGENT] {
            
            isAgent = dicAgent as! Bool
            
        }
        else
        {
            
            isAgent = false
            
        }
        
        //check if phoneNumber exist
        if let dicPhoneNumber = _dictionary[kPHONE] {
            
            phoneNumber = dicPhoneNumber as! String
            
        }
        else
        {
            
            phoneNumber = ""
            
        }
        
        //check if additional number exist
        if let dicAddPhoneNumber = _dictionary[kADDPHONE] {
            
            additionalPhoneNumber = dicAddPhoneNumber as! String
            
        }
        else
        {
            
            additionalPhoneNumber = ""
            
        }
        
        //check if favourite exist
        if let dicFavourite = _dictionary[kFAVOURITE] {
            
            favouriteProperties = dicFavourite as! [String]
            
        }
        else
        {
            
            favouriteProperties = []
            
        }
    
    }
    
    // return currentId
    class func currentId() -> String {
        
        return Auth.auth().currentUser!.uid
        
    }
    
    //return current loged in user
    class func currentUser() -> FirebaseUser? {
        
        if Auth.auth().currentUser != nil
        {
        if let dictionary = UserDefaults.standard.object(forKey: kCURRENTUSER)
        {
            
        return FirebaseUser.init(_dictionary: dictionary as! NSDictionary)
            
        }
        
       }
        return nil
    }
    
    class func registerUserWith(email: String, password: String, firstName: String, lastName: String, completion: @escaping (_ error: Error?)-> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (firebaseUser, error) in
           
            if error != nil {
                completion(error)
                return
            }
            
            let firebaseUser = FirebaseUser(_objectId: firebaseUser!.uid, _createdAt: Date(), _updatedAt: Date(), _firstName: firstName, _lastName: lastName)
            
            //save user to userdefault
            saveUserLocally(firebaseUser: firebaseUser)
            
            //save user in background to firebase database
            saveUserInBackground(firebaseUser: firebaseUser)
            
            completion(error)
        }
    }
    
    class func registerUserWith(phoneNumber: String, verificationCode: String, completion: @escaping (_ error: Error?, _ shouldLogin: Bool)-> Void) {
    
        let verificationId = UserDefaults.standard.value(forKey: kVERIFICATIONCODE)
        
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId as! String, verificationCode: verificationCode)
        Auth.auth().signIn(with: credentials) { (firebaseUser, error) in
            
            if error != nil {
                completion(error!, false)
                return
            }
            
            //check if user is logged in else register the user
            fetechUserWith(userId: firebaseUser!.uid, completion: { (user) in
                
                if user != nil && user!.firstName != "" {
                    //we have a user, so login
                    saveUserLocally(firebaseUser: user!)
                    completion(error, true)
                }
                else
                {
                    //no user, so register
                    let fUser = FirebaseUser(_objectId: firebaseUser!.uid, _createdAt: Date(), _updatedAt: Date(), _firstName: "", _lastName: "", _phoneNumber: firebaseUser!.phoneNumber!)
                    saveUserLocally(firebaseUser: fUser)
                    saveUserInBackground(firebaseUser: fUser)
                    completion(error, false)
                }
            })
        }
        
    }
    
}// end of class

//MARK: SAVING USER

//func to save to database
func saveUserInBackground(firebaseUser: FirebaseUser)
{
    
    let ref = fireBase.child(kUSER).child(firebaseUser.objectId)
    ref.setValue(userDictionaryFrom(user: firebaseUser))
    
}

//func to save to userdefault
func saveUserLocally(firebaseUser: FirebaseUser)
{
    //converts user from dictionary to currentuser
    UserDefaults.standard.set(userDictionaryFrom(user: firebaseUser), forKey: kCURRENTUSER)
    //save
    UserDefaults.standard.synchronize()
    
}


//MARK: HELPER FUNCTIONS

//convert user to dictionary
func userDictionaryFrom(user: FirebaseUser)-> NSDictionary {
    
    //convert date to string to store
    let createdAt = dateFormatter().string(from: user.createdAt)
    let updatedAt = dateFormatter().string(from: user.updatedAt)
    
    return NSDictionary(objects: [user.objectId, createdAt, updatedAt, user.companyName, user.firstName, user.lastName, user.fullName, user.avatar, user.phoneNumber, user.additionalPhoneNumber, user.isAgent, user.coins, user.favouriteProperties], forKeys: [kOBJECTID as NSCopying, kCREATEDAT as NSCopying, kUPDATEDAT as NSCopying, kCOMPANY as NSCopying, kFIRSTNAME as NSCopying, kLASTNAME as NSCopying, kFULLNAME as NSCopying, kAVATAR as NSCopying, kPHONE as NSCopying, kADDPHONE as NSCopying, kISAGENT as NSCopying, kCOINS as NSCopying, kFAVOURITE as NSCopying])
    
}

func fetechUserWith(userId: String, completion: @escaping (_ user: FirebaseUser?)-> Void)
{
    fireBase.child(kUSER).queryOrdered(byChild: kOBJECTID).queryEqual(toValue: userId).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists(){
            let userDictionary = ((snapshot.value as! NSDictionary).allValues as NSArray).firstObject! as! NSDictionary
            let user = FirebaseUser(_dictionary: userDictionary)
            completion(user)
        }
        else
        {
            completion(nil)
        }
    }
    
}

func updateCurrentUser(withValues: [String: Any], withBlock: @escaping (_ success: Bool)-> Void )
{
    if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil
    {
        let currentUser = FirebaseUser.currentUser()!
        
        let userObject = userDictionaryFrom(user: currentUser).mutableCopy as! NSMutableDictionary
        userObject.setValuesForKeys(withValues)
        
        let ref = fireBase.child(kUSER).child(currentUser.objectId)
        ref.updateChildValues(withValues, withCompletionBlock: { (error, ref) in
            if error != nil {
                withBlock(false)
                return
            }
            
            UserDefaults.standard.setValue(userObject, forKey: kCURRENTUSER)
            UserDefaults.standard.synchronize()
            
            withBlock(true)
            
        })
    }
}



