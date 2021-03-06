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
        static let orange = "#ff6501"
        static let pink = "fe01a9"
        static let buttonBorderWhite = "#ffffff"
        static let lightBlue = "#00cdff"
        static let lightGreen = "#00f0ac"
    }
    
    struct Endpoints {
        static let mentions = "https://api.twitter.com/1.1/statuses/mentions_timeline.json"
        static let userTimeLine = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
        static let search = "https://api.twitter.com/1.1/search/tweets.json?q=%23"
        static let searchUser = "https://api.twitter.com/1.1/users/search.json?q=Twitter%20"
        static let followers = "https://api.twitter.com/1.1/followers/list.json?"
    }
    
    
}
