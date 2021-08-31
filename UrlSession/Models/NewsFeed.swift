//
//  NewsFeed.swift
//  UrlSession
//
//  Created by Mangi on 14/04/21.
//  Copyright © 2021 Mangi. All rights reserved.
//

import Foundation

struct NewsFeed: Codable {
    
    var status:String = ""
    var totalResults:Int = 0
    var articles:[Articles]
}
