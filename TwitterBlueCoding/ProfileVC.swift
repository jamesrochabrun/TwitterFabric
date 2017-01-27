//
//  TimeLineVCTableViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class ProfileVC : UIViewController, ProfileViewDelegate  {
    
    let session = Twitter.sharedInstance().sessionStore.session()
    

    lazy var profileView: ProfileView = {
        let view = ProfileView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        view.center = self.view.center
    
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        view.addSubview(profileView)
        profileView.delegate = self
        loadUserInfo()
        //composeTweet()
    }
    
    func showVC() {
        
        let followersVC = FollowersVC()
        let navigationVC = UINavigationController(rootViewController: followersVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }

    
    func handleLogOut() {
        
        let userDefaults = UserDefaults.standard
        let userID = userDefaults.string(forKey: "userID")
        
        Twitter.sharedInstance().sessionStore.logOutUserID((userID!))
        userDefaults.set(session?.userID, forKey: "userID")
        userDefaults.synchronize()
        self.dismiss(animated: true)
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
                if let tweeterUser = user {
                    self.setUpUserProfile(tweeterUser)
                }
            }
        }
    }
    
    func setUpUserProfile(_ user:TWTRUser) {
        
            DispatchQueue.main.async {
                self.navigationItem.title = user.screenName
                print("UUUUUUUUUU : \(user.screenName)")
                //CREATE  A SUBVIEW PROFILE FOR USER DATA
                self.profileView.configureViewWithUser(user)
                
        }
    }

}






