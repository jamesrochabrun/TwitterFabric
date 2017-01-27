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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load()
        //test()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }
    
    
    func load() {
        
        let userID = Twitter.sharedInstance().sessionStore.session()?.userID
        let client = TWTRAPIClient(userID: userID)
        
        //self.dataSource = TWTRUserTimelineDataSource(screenName: "fabric", apiClient: client)
        
        
        client.loadUser(withID:userID!) { (user, error) in
            print("USER!!: \(user?.name)")
        }
        
        let statusesShowEndpoint = "https://api.twitter.com/1.1/followers/list.json?"
        let params = ["id": userID]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod:"GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print("json: \(json)")
                
                //let user  = json["users"] as! [String: Any]
                
                
                
//                let tweetData = TWTRTweet.tweets(withJSONArray: [json])
//                
//                print("count: \(tweetData)")
                // tableView.reloadData()
                
                
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
    }

}
