//
//  TimeLineVCTableViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class TimeLineVC: UITableViewController {
    
    let session = Twitter.sharedInstance().sessionStore.session()
    let label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        
        //loadUserInfo()
        //loadUserFollowers()
        loadUserTweets()
        
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
    
    func loadUserFollowers() {
        
        guard let userID = self.session?.userID else {
            print("NO USERID")
            return
        }
        let client = TWTRAPIClient(userID: userID)
        let endPoint = "https://api.twitter.com/1.1/followers/list.json?"
        let params = ["id": userID]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod:Constants.HTTPMethods.get, url: endPoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
               // print("json: \(json)")
                let users  = json["users"] as! [[String: Any]]
                for user in users {
                    if let twitterUser = TWTRUser(jsonDictionary: user) {
                        print("USERname = \(twitterUser.name)")
                        
                        //ADD THE USER IN AN ARRAY AND DISPLAY DATA
                        //RELOAD TABLEVIEW
                    } else {
                      print("TWITTERUSER NOT INITIALIZED")
                    }
                }
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    func loadUserTweets() {
        
        guard let userID = self.session?.userID else {
            print("NO USERID")
            return
        }
        let client = TWTRAPIClient(userID: userID)
        let endPoint = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
        let params = ["id": userID,
                      "count": "10"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod:Constants.HTTPMethods.get, url: endPoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                print("json: \(json)")
                let tweets = TWTRTweet.tweets(withJSONArray: json)
                
                print("Count: \(tweets.count)")
                //http://stackoverflow.com/questions/29389474/access-twitter-user-timeline-using-fabric-sdk-ios do this

            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
}
