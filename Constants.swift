//
//  Constants.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

struct Constants {
    struct HTTPMethods {
        static let get = "GET"
        static let post = "POST"
        static let delete = "DELETE"
        static let put = "PUT"
    }
    
    struct APPColor {
        static let coral = "#fe486c"
        static let purple = "#ff7555"
        static let buttonBorderWhite = "#ffffff"
    }
    
    struct Endpoints {
        static let mentions = "https://api.twitter.com/1.1/statuses/mentions_timeline.json"
        static let userTimeLine = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
    }
    
    
}
