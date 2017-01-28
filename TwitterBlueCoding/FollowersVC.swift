//
//  FollowersVC.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class FollowersVC: UITableViewController {
    
    let session = Twitter.sharedInstance().sessionStore.session()
    private let cellID = "cell"
    var twitterUsersArray: [TWTRUser] = []
    var currentUser:TWTRUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let u = self.currentUser {
            setUpNavBarWithUser(user:u)
        }

        loadUserFollowers()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissView))
    }
    
    func dismissView() {
        self.navigationController?.dismiss(animated: true)
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
                        print("USERNAME = \(twitterUser.name)")
                        
                        //ADD THE USER IN AN ARRAY AND DISPLAY DATA
                        self.twitterUsersArray.append(twitterUser)
                        //RELOAD TABLEVIEW
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }

                    } else {
                        print("TWITTERUSER NOT INITIALIZED")
                    }
                }
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return twitterUsersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! UserCell
        let twitterUser = twitterUsersArray[indexPath.row]
        cell.textLabel?.text = twitterUser.name
        cell.detailTextLabel?.text = twitterUser.description
        cell.profileImageView.loadImageUsingCacheWithURLString(twitterUser.profileImageURL)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = twitterUsersArray[indexPath.row]
        let profileVC = ProfileVC ()
        profileVC.user = user
        let navVC = UINavigationController(rootViewController: profileVC)
        self.present(navVC, animated: true)
    }
}

extension FollowersVC {
    
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

class UserCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.cornerRadius = 24
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textLabel = self.textLabel {
            self.textLabel?.frame = CGRect(x: 64, y: (textLabel.frame.origin.y - 2), width: (textLabel.frame.size.width), height: (textLabel.frame.size.height))
        }
        
        if let detailTextLabel = self.detailTextLabel {
            self.detailTextLabel?.frame = CGRect(x: 64, y: (detailTextLabel.frame.origin.y + 2), width: (detailTextLabel.frame.size.width), height: (detailTextLabel.frame.size.height))
        }
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








