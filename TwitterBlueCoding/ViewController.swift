//
//  ViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTwitterButton()
    }

    private func setUpTwitterButton() {
        
        let twitterButton = TWTRLogInButton { (session, error) in
            
            if let err = error {
                print("ERROR SETTING UP TWIITER BUTTON: \(err)")
                return
            }
            print("SUCCESFULLY LOGED IN")
        }
        view.addSubview(twitterButton)
        twitterButton.center = view.center
    }
}

