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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: topView.frame.size.height)
        
    }

   

}
