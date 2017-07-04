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
            print("User: \(user.screenName)")
            //CREATE  A SUBVIEW PROFILE FOR USER DATA
            self.profileView.configureViewWithUser(user)
            
        }
    }
    
    //MARK:Buttons actions
    
    func showMentions() {
        
        let feedVC = FeedVC()
        feedVC.endPoint = Constants.Endpoints.mentions
        feedVC.isHashtag = false
        feedVC.currentUser = self.currentUser
        let navVC = UINavigationController(rootViewController: feedVC)
        self.present(navVC, animated: true)
    }
    
    func showFeedFromQuery() {
        
        let alertController = UIAlertController(title: "Enter a query ", message: "", preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: {
            alert -> Void in
            
            let queryTextField = alertController.textFields![0] as UITextField
            
            var queryText = queryTextField.text
            if let count = queryText?.length {
                
                if count <= 0 {
                    queryText = "nohashtag"
                } else {
                    queryText = queryTextField.text
                }
                if let query = queryText {
                    let feedVC = FeedVC()
                    feedVC.endPoint = Constants.Endpoints.search + query
                    feedVC.isHashtag = true
                    feedVC.currentUser = self.currentUser
                    let navVC = UINavigationController(rootViewController: feedVC)
                    self.present(navVC, animated: true)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter a word"
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showUserFeed() {
        
        let feedVC = FeedVC()
        feedVC.endPoint = Constants.Endpoints.userTimeLine
        feedVC.isHashtag = false
        feedVC.currentUser = self.currentUser
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
        
        let usersVC = UsersVC()
        usersVC.currentUser = self.currentUser
        usersVC.isSearch = false
        usersVC.endPoint = Constants.Endpoints.followers
        let navigationVC = UINavigationController(rootViewController: usersVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    func showUsersFromSearch() {
        
        let alertController = UIAlertController(title: "Enter a query", message: "", preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: {
            alert -> Void in
            
            let queryTextField = alertController.textFields![0] as UITextField
            
            if let queryText = queryTextField.text?.replacingOccurrences(of: " ", with: "") {
                let usersVC = UsersVC()
                usersVC.currentUser = self.currentUser
                usersVC.isSearch = true
                usersVC.endPoint = Constants.Endpoints.searchUser + queryText
                let navigationVC = UINavigationController(rootViewController: usersVC)
                self.present(navigationVC, animated: true, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter a word"
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }

    
    
    
    
    
    
}
