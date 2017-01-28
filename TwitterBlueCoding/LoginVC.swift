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
    
    let session = Twitter.sharedInstance().sessionStore.session()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hexStringToUIColor(Constants.APPColor.coral)
        checkIfUserIsLoggedIn()
        setUpTwitterButton()
    }

    private func setUpTwitterButton() {
        
        let twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("ERROR SETTING UP TWIITER BUTTON LOGIN IN: \(err)")
                return
            }
            
            if let userID = session?.userID {
                let userDefaults = UserDefaults.standard
                userDefaults.set(userID, forKey: "userID")
                userDefaults.synchronize()
                let profileVC = ProfileVC()
                let navVC = UINavigationController(rootViewController: profileVC)
                self.present(navVC, animated: true)
            }
            
            if let token = session?.authToken {
                print("TOKEN: \(token)")
                print("USERNAME : \(session?.userName)")
                print("id: \(session?.userID)")

            }
            if let secretToken = session?.authTokenSecret {
                print("TOKEN SECRET: \(secretToken)")
            }
            
            print("SUCCESFULLY LOGGED IN")
        }
        view.addSubview(twitterButton)
        twitterButton.center = view.center
    }
    
    public func checkIfUserIsLoggedIn() {
        
        let userDefaults = UserDefaults.standard
        let userID = userDefaults.string(forKey: "userID")
        
        print("USERID111: \(userID)")
        //si userid no fue guardado
        if userID != nil {
            let profileVC = ProfileVC()
            let navVC = UINavigationController(rootViewController: profileVC)
            self.present(navVC, animated: true)
        }
        
    }
    
    
    
    
    
    
    
    

}

