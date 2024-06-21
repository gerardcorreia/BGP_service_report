//
//  Item.swift
//  BGP_Service_Report
//
//  Created by user259062 on 6/19/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
