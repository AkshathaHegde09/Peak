//
//  PropertyCollectionViewCell.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var bathRoomLabel: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var topAdImageView: UIImageView!
    @IBOutlet weak var soldImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    //setup of collectionViewCell
    func generateCell(property: Property) {
        
        titleLabel.text = property.title
        roomLabel.text = "\(property.numberOfRooms)"
        bathRoomLabel.text = "\(property.numberOfBathrooms)"
        parkingLabel.text = "\(property.parking)"
        
        priceLabel.text = "\(property.price)"
        priceLabel.sizeToFit()
    }
    
    @IBAction func starButtonPressed(_ sender: Any) {
        
    }
    
    
}
