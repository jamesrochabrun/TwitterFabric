//
//  TimeLineVCTableViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class ProfileVC : UIViewController {
    
    let session = Twitter.sharedInstance().sessionStore.session()

    
    let label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(label)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))


        //loadUserInfo()
        //loadUserFollowers()
        //loadUserTweets()
        composeTweet()
    }
    
    func composeTweet() {
        
        let composer = TWTRComposer()
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
            }
        }
        
    }
    
    func handleLogOut() {
        do {
            //try logout
        } catch let logoutError {
            print(logoutError)
        }
        let userTweetsVC = FollowersVC()//UserTweetsFeedVC()
        let navigationVC = UINavigationController(rootViewController: userTweetsVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadUserInfo() {
        
        if let uID = self.session?.userID  {
            let client = TWTRAPIClient(userID: uID)
            client.loadUser(withID:uID) { (user, error) in
                if error != nil {
                    print("ERROR LOADING USER INFO")
                }
                //handle user pofile setup
                self.setUpUserProfile(user)
            }
        }
    }
    
    func setUpUserProfile(_ user:TWTRUser?) {
        
        if let u = user {
            DispatchQueue.main.async {
                self.navigationItem.title = u.screenName
                print("U : \(u.screenName)")
                self.label.text = u.screenName
                //CREATE  A SUBVIEW PROFILE FOR USER DATA
            }
        }
    }

}
