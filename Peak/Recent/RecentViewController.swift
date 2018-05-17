//
//  RecentViewController.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PropertyCollectionViewCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var properties: [Property] = []
    
    var numberOfPropertiesTextField: UITextField?
    
    override func viewWillLayoutSubviews() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProperties(limitNumber: kRECENTPROPERTYLIMIT)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //MARK: COLLECTIONVIEW Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(254))
    }
    
    
    //MARK: COLLECTIONVIEW DATASOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PropertyCollectionViewCell
        //cell.delegate = self
        cell.generateCell(property: properties[indexPath.row])
        
        return cell
    }
    
    //MARK: LOAD PROPERTIES
    
    func loadProperties(limitNumber: Int) {
        Property.fetchRecentProperty(limitNumber: limitNumber) {(allProperties) in
            if allProperties.count != 0 {
                self.properties = allProperties as! [Property]
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: IBACTION
    
    @IBAction func mixerButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Update", message: "Set the number of properties to dispaly", preferredStyle: .alert)
        alertController.addTextField {(numberOfProperties) in
            numberOfProperties.placeholder = "Number of Properties"
            numberOfProperties.borderStyle = .roundedRect
            numberOfProperties.keyboardType = .numberPad
            
            self.numberOfPropertiesTextField = numberOfProperties
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (action) in
            if self.numberOfPropertiesTextField?.text != "" && self.numberOfPropertiesTextField?.text != "0" {
                ProgressHUD.show("Updating...")
                self.loadProperties(limitNumber: Int(self.numberOfPropertiesTextField!.text!)!)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(updateAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //Mark: PropertyCollectionViewCellDelegate
    
    func didClickStarButton(property: Property) {
        //check if user is logged in
        if FirebaseUser.currentUser() != nil {
            let user = FirebaseUser.currentUser()!
            
            //check if property is in favourite property
            if user.favouriteProperties.contains(property.objectId!)
            {
                //remove from favourite list
                let index = user.favouriteProperties.index(of: property.objectId!)
                user.favouriteProperties.remove(at: index!)
                updateCurrentUser(withValues: [kFAVOURITE: user.favouriteProperties], withBlock: {(success) in
                    if !success {
                        print("Error: removing favourite")
                    }
                    else
                    {
                        self.collectionView.reloadData()
                        ProgressHUD.showSuccess("Removed from the list")
                    }
                })
            }
            else
            {
                //add to favourite list
                user.favouriteProperties.append(property.objectId!)
                updateCurrentUser(withValues: [kFAVOURITE: user.favouriteProperties], withBlock: {(success) in
                    if !success {
                        print("Error: adding property")
                    }
                    else
                    {
                        self.collectionView.reloadData()
                        ProgressHUD.showSuccess("Added to the list")
                    }
                })
            }
        }
        else
        {
            //show register view
            
        }
    }
}
