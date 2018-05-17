//
//  AddPropertyViewController.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit

class AddPropertyViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    
    //textFields
    @IBOutlet weak var referenceCodeTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var roomsTextField: UITextField!
    @IBOutlet weak var bathroomsTextField: UITextField!
    @IBOutlet weak var balconySizeTextField: UITextField!
    @IBOutlet weak var parkingTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var adTypeTextField: UITextField!
    @IBOutlet weak var availableFromTextField: UITextField!
    @IBOutlet weak var buildYearTextField: UITextField!
    @IBOutlet weak var propertyTypeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var propertySizeTextField: UITextField!
    
    //textView
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //switches
    @IBOutlet weak var titleDeedsSwitch: UISwitch!
    @IBOutlet weak var centralHeatingSwitch: UISwitch!
    @IBOutlet weak var solarWaterHeatingSwitch: UISwitch!
    @IBOutlet weak var storeRoomSwitch: UISwitch!
    @IBOutlet weak var acSwitch: UISwitch!
    @IBOutlet weak var furnishedSwitch: UISwitch!
    
    var user: FirebaseUser?
    
     var titleDeedsSwitchValue = false
     var centralHeatingSwitchValue = false
     var solarWaterHeatingSwitchValue = false
     var storeRoomSwitchValue = false
     var acSwitchValue = false
     var furnishedSwitchValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: topView.frame.size.height)
        
    }

    //MARK: IBACTIONS
    
    @IBAction func cameraAction(_ sender: Any) {
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        user = FirebaseUser.currentUser()!
        
        if !user!.isAgent {
            //check user can post
            save()
        }
        else
        {
            save()
        }
        
    }
    
    @IBAction func pinLocationAction(_ sender: Any) {
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
    }
    
    //MARK: HELPER FUNCTION
    
    func save()
    {
        if titleTextField.text != "" && referenceCodeTextField.text != "" && adTypeTextField.text != "" && propertyTypeTextField.text != "" && priceTextField.text != ""
        {
            //create new property
            var newProperty = Property()
            
            newProperty.referenceCode = referenceCodeTextField.text!
            newProperty.ownerId = user!.objectId
            newProperty.title = titleTextField.text!
            newProperty.adType = adTypeTextField.text!
            newProperty.price = Int(priceTextField.text!)!
            newProperty.propertyType = propertyTypeTextField.text!
            
            if balconySizeTextField.text != "" {
                newProperty.balconySize = Double(balconySizeTextField.text!)!
            }
            if bathroomsTextField.text != "" {
                newProperty.numberOfBathrooms = Int(bathroomsTextField.text!)!
            }
            if buildYearTextField.text != "" {
                newProperty.buildYear = buildYearTextField.text!
            }
            if parkingTextField.text != "" {
                newProperty.parking = Int(parkingTextField.text!)!
            }
            if roomsTextField.text != "" {
                newProperty.numberOfRooms = Int(roomsTextField.text!)!
            }
            if propertySizeTextField.text != "" {
                newProperty.size = Double(propertySizeTextField.text!)!
            }
            if addressTextField.text != "" {
                newProperty.address = addressTextField.text!
            }
            if cityTextField.text != "" {
                newProperty.city = cityTextField.text!
            }
            if countryTextField.text != "" {
                newProperty.country = countryTextField.text!
            }
            if availableFromTextField.text != "" {
                newProperty.availableFrom = availableFromTextField.text!
            }
            if floorTextField.text != "" {
                newProperty.floor = Int(floorTextField.text!)!
            }
            if descriptionTextView.text != "" && descriptionTextView.text != "Description"{
                newProperty.propertyDescription = descriptionTextView.text!
            }
            
            //switch values
            newProperty.titleDeeds = titleDeedsSwitchValue
            newProperty.centralHeating = centralHeatingSwitchValue
            newProperty.waterHeating = solarWaterHeatingSwitchValue
            newProperty.ac = acSwitchValue
            newProperty.storeRoom = storeRoomSwitchValue
            newProperty.isFurnished = furnishedSwitchValue
            
            newProperty.saveProperty()
            ProgressHUD.showSuccess("Saved!")
        }
        else
        {
            ProgressHUD.showError("Error: Missing required fields")
        }
    }
    
    //Switches
    @IBAction func titleDeedsAction(_ sender: Any) {
        titleDeedsSwitchValue = !titleDeedsSwitchValue
    }
    
    @IBAction func centralHeatingAction(_ sender: Any) {
        centralHeatingSwitchValue = !centralHeatingSwitchValue
    }
    
    @IBAction func solarWaterHeatingAction(_ sender: Any) {
        solarWaterHeatingSwitchValue = !solarWaterHeatingSwitchValue
    }
    
    @IBAction func storeRoomAction(_ sender: Any) {
        storeRoomSwitchValue = !storeRoomSwitchValue
    }
    
    @IBAction func acAction(_ sender: Any) {
        acSwitchValue = !acSwitchValue
    }
    
    @IBAction func furnishedAction(_ sender: Any) {
        furnishedSwitchValue = !furnishedSwitchValue
    }
    
}

