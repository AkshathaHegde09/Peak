//
//  Settings.swift
//  Peak
//
//  Created by akshatha hegde on 5/16/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import Foundation

//Date formatter
private let dateFormat = "yyyyMMddHHmmss"
func dateFormatter() -> DateFormatter
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter
}
