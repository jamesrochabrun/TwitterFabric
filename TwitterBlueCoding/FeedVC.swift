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
    var isHashtag: Bool = false
    var currentUser:TWTRUser?
    private let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let u = self.currentUser {
            setUpNavBarWithUser(user:u)
        }
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
                    
                    if self.isHashtag {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        print("json: \(json)")
                        let arr = json["statuses"] as! [[String: Any]]
                        self.tweets = TWTRTweet.tweets(withJSONArray: arr) as! [TWTRTweet]
                        print("TEXT: \(self.tweets.first?.text)")
                    } else {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                        print("json: \(json)")
                        self.tweets = TWTRTweet.tweets(withJSONArray: json) as! [TWTRTweet]
                        print("TEXT: \(self.tweets.first?.text)")
                    }
  
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


extension FeedVC {
    
    func setUpNavBarWithUser(user: TWTRUser) {
        
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.loadImageUsingCacheWithURLString(user.profileImageURL)
        containerView.addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        let nameLabel = UILabel()
        containerView.addSubview(nameLabel)
        nameLabel.text = user.screenName
        nameLabel.textColor = UIColor.white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
    }
}
