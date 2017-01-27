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
    
    lazy var button: UIButton = {
        let b = UIButton()
        b.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        b.addTarget(self, action: #selector(showFollowersVC), for: .touchUpInside)
        b.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(button)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        
        //loadUserInfo()
        //composeTweet()
    }

    
    func handleLogOut() {
        
        let userDefaults = UserDefaults.standard
        let userID = userDefaults.string(forKey: "userID")
        
        Twitter.sharedInstance().sessionStore.logOutUserID((userID!))
        userDefaults.set(session?.userID, forKey: "userID")
        userDefaults.synchronize()
        self.dismiss(animated: true)
    }
    

    
    func showFollowersVC() {
        
        let followersVC = FollowersVC()
        let navigationVC = UINavigationController(rootViewController: followersVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    func showUserLastTweetsVC() {
        
        let userTweetsVC = UserTweetsFeedVC()
        let navigationVC = UINavigationController(rootViewController: userTweetsVC)
        self.present(navigationVC, animated: true, completion: nil)
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
                //CREATE  A SUBVIEW PROFILE FOR USER DATA
            }
        }
    }

}
