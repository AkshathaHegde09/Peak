//
//  RecentViewController.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var properties: [Property] = []
    
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
        
    }
    
}
