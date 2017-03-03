//
//  RecentCalculateData.swift
//  TipCalculator
//
//  Created by yanze on 3/1/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import Foundation

class RecentCalculateData: NSObject {
    
    static let instance = RecentCalculateData()
    
    var checkAmount: Float!
    var tipPercentageIndex: Int!
    var numberOfPeople: Int!
    var totalPerPersonToPay: String?
    
}
