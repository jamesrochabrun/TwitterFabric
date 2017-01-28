//
//  ProfileVC+handlers.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

extension MainVC {
    
    func handleLogOut() {
        
        let userDefaults = UserDefaults.standard
        let userID = userDefaults.string(forKey: "userID")
        
        Twitter.sharedInstance().sessionStore.logOutUserID((userID!))
        userDefaults.set(session?.userID, forKey: "userID")
        userDefaults.synchronize()
        self.dismiss(animated: true)
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
                    self.currentUser = tweeterUser
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
    
    //MARK:Buttons actions
    
    func showMentions() {
        
        let feedVC = FeedVC()
        feedVC.endPoint = Constants.Endpoints.mentions
        let navVC = UINavigationController(rootViewController: feedVC)
        self.present(navVC, animated: true)
    }
    
    func showUserFeed() {
        
        let feedVC = FeedVC()
        feedVC.endPoint = Constants.Endpoints.userTimeLine
        let navVC = UINavigationController(rootViewController: feedVC)
        self.present(navVC, animated: true)
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
    
    func showFollowers() {
        
        let followersVC = FollowersVC()
        followersVC.currentUser = self.currentUser
        let navigationVC = UINavigationController(rootViewController: followersVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
    

    
    
    
    
    
    
}
