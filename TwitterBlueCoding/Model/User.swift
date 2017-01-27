//
//  User.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class User: NSObject {

        let name: String
        let age: Int
        
        init?(dict:[String : AnyObject]) {
            
            guard let name = dict["name"] as? String, let age = dict["age"] as? Int else {
                return nil
            }
            self.name = name
            self.age = age
        }
}
