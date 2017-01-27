//
//  ViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class LoginVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTwitterButton()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }

    private func setUpTwitterButton() {
        
        
        let twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("ERROR SETTING UP TWIITER BUTTON LOGIN IN: \(err)")
                return
            }
            if let token = session?.authToken {
                print("TOKEN: \(token)")
                print("USERNAME : \(session?.userName)")
                print("id: \(session?.userID)")

            }
            if let secretToken = session?.authTokenSecret {
                print("TOKEN SECRET: \(secretToken)")
            }
            
            let profileVC = ProfileVC()
            let navController = UINavigationController(rootViewController: profileVC)
            self.present(navController, animated:true)
            
            print("SUCCESFULLY LOGGED IN")
        }
        view.addSubview(twitterButton)
        twitterButton.center = view.center
    }

}

