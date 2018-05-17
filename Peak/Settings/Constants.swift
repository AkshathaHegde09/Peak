//
//  Constants.swift
//  Peak
//
//  Created by akshatha hegde on 5/14/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import Foundation
import Firebase

//Backendless variable
var backendless = Backendless.sharedInstance()

//Firebase database reference variable
var fireBase = Database.database().reference()

//Firebase user
public let kOBJECTID = "objectId"
public let kUSER = "User"

public let kCREATEDAT = "createdAt"
public let kUPDATEDAT = "updatedAt"

public let kCOMPANY = "company"
public let kPHONE = "phone"
public let kADDPHONE = "addPhone"

public let kCOINS = "coins"

public let kFIRSTNAME = "firstName"
public let kLASTNAME = "lastName"
public let kFULLNAME = "fullName"
public let kAVATAR = "avatar"
public let kCURRENTUSER = "currentUser"
public let kISONLINE = "isOnline"
public let kVERIFICATIONCODE = "verificationCode"
public let kISAGENT = "isAgent"
public let kFAVOURITE = "favouriteProperties"

//Property
public let kMAXIMAGENUMBER = 10
public let kRECENTPROPERTYLIMIT = 20



