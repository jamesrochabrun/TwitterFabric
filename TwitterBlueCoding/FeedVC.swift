//
//  FeedVC.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class FeedVC: UITableViewController {
    
    let session = Twitter.sharedInstance().sessionStore.session()
    var tweets: [TWTRTweet] = []
    var endPoint: String = ""
    private let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CLOSE", style: .plain, target: self, action: #selector(dismissView))
        loadFeed()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = true
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: cellID)
    }

    func dismissView() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func loadFeed() {
        
        guard let userID = self.session?.userID else {
            print("NO USERID")
            return
        }
        let client = TWTRAPIClient(userID: userID)
        let params = ["id": userID, "count" : "20"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod:Constants.HTTPMethods.get, url: self.endPoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            do {
                if let data = data {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                    print("json: \(json)")
                    self.tweets = TWTRTweet.tweets(withJSONArray: json) as! [TWTRTweet]
                    print("TEXT: \(self.tweets.first?.text)")
                    
                    print("Count: \(self.tweets.count)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    //SHOW A ALERTCONTROLLER
                    print("SHOW ALERT CONTROLLER")
                }
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TWTRTweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.configure(with: tweet)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let tweet = tweets[indexPath.row]
        return TWTRTweetTableViewCell.height(for: tweet, style: .compact, width: view.bounds.width, showingActions: false)
        
    }



}