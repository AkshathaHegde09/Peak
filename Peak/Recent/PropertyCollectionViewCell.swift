//
//  PropertyCollectionViewCell.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit

@objc protocol PropertyCollectionViewCellDelegate {
    @objc optional func didClickStarButton(property: Property)
    
}

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
    
    var property: Property!
    
    var delegate: PropertyCollectionViewCellDelegate?
    
    //setup of collectionViewCell
    func generateCell(property: Property) {
        
        self.property = property
        
        titleLabel.text = property.title
        roomLabel.text = "\(property.numberOfRooms)"
        bathRoomLabel.text = "\(property.numberOfBathrooms)"
        parkingLabel.text = "\(property.parking)"
        
        priceLabel.text = "\(property.price)"
        priceLabel.sizeToFit()
        
        //sold status
        if property.isSold {
            soldImageView.isHidden = false
        }
        else
        {
            soldImageView.isHidden = true
        }
        
        //topAd status
        if property.inTopUntil != nil && property.inTopUntil! > Date() {
            topAdImageView.isHidden = false
        }
        else
        {
            topAdImageView.isHidden = true
        }
        
        //image
        if property.imageLink != "" && property.imageLink != nil
        {
            //download image
        }
        else
        {
            self.imageView.image = UIImage(named: "propertyPlaceholder")
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
        }
        
    }
    
    @IBAction func starButtonPressed(_ sender: Any) {
        delegate!.didClickStarButton!(property: property)
    }
    
    
}
