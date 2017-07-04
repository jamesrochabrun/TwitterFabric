//
//  TimeLineVCTableViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class MainVC : UIViewController , ProfileViewDelegate {
    
    let session = Twitter.sharedInstance().sessionStore.session()
    var currentUser:TWTRUser?
    
    //UIConstants
    let widthButton: CGFloat = 270.0
    let heightbutton: CGFloat = 44.0
    let padding: CGFloat = 7.0
    let borderWidth: CGFloat = 2.0
    let cornerRadius: CGFloat = 20
    let fontSize: CGFloat = 18
    

    lazy var profileView: ProfileView = {
        let view = ProfileView(frame: CGRect(x:(self.view.frame.size.width - 210)/2, y: 64, width: 210, height: 210))
        return view
    }()
    
    lazy var gradientView: UIView = {
        let gv = UIView()
        gv.frame = self.view.frame
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.hexStringToUIColor(Constants.APPColor.lightGreen).cgColor, UIColor.hexStringToUIColor(Constants.APPColor.lightBlue).cgColor]
        gv.layer.insertSublayer(gradient, at: 0)
        return gv
    }()
    
    lazy var followersButton: UIButton = {
        let button = UIButton()
        button.createCustomButtonWith(title: "Show Followers", target: self, selector: #selector(showFollowers), borderWidth: self.borderWidth, cornerRadius: self.cornerRadius, fontSize: self.fontSize, inView: self.view)
        return button
    }()
    
    lazy var tweetsButton : UIButton = {
        let button = UIButton()
        button.createCustomButtonWith(title: "Show personal Twits", target: self, selector: #selector(showUserFeed), borderWidth: self.borderWidth, cornerRadius: self.cornerRadius, fontSize: self.fontSize, inView: self.view)
        return button
    }()
    
    lazy var tweetButton : UIButton = {
        let button = UIButton()
        button.createCustomButtonWith(title: "Make a twit", target: self, selector: #selector(composeTweet), borderWidth: self.borderWidth, cornerRadius: self.cornerRadius, fontSize: self.fontSize, inView: self.view)
        return button
    }()
    
    lazy var mentionButton : UIButton = {
        let button = UIButton()
        button.createCustomButtonWith(title: "Show Mentions", target: self, selector: #selector(showMentions), borderWidth: self.borderWidth, cornerRadius: self.cornerRadius, fontSize: self.fontSize, inView: self.view)
        return button
    }()
    
    lazy var hashtagButton : UIButton = {
        let button = UIButton()
        button.createCustomButtonWith(title: "Search with hashtag", target: self, selector: #selector(showFeedFromQuery), borderWidth:self.borderWidth, cornerRadius: self.cornerRadius, fontSize: self.fontSize, inView: self.view)
        return button
    }()
    
    lazy var searchUserButton : UIButton = {
        let button = UIButton()
        button.createCustomButtonWith(title: "Find users with name", target: self, selector: #selector(showUsersFromSearch), borderWidth: self.borderWidth, cornerRadius: self.cornerRadius, fontSize: self.fontSize, inView: self.view)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        view.addSubview(gradientView)
        view.addSubview(profileView)
        profileView.delegate = self
        loadUserInfo()
    }
    
    func showVC() {
        
        let profileVC = ProfileVC()
        profileVC.user = self.currentUser
        let navVC = UINavigationController(rootViewController: profileVC)
        self.present(navVC, animated: true)
    }
    
 
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tweetButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: padding).isActive = true
        tweetButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        tweetButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        tweetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tweetsButton.topAnchor.constraint(equalTo: tweetButton.bottomAnchor, constant:padding).isActive = true
        tweetsButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        tweetsButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        tweetsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        followersButton.topAnchor.constraint(equalTo: tweetsButton.bottomAnchor, constant:padding).isActive = true
        followersButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        followersButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        followersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        followersButton.topAnchor.constraint(equalTo: tweetsButton.bottomAnchor, constant:padding).isActive = true
        followersButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        followersButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        followersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mentionButton.topAnchor.constraint(equalTo: followersButton.bottomAnchor, constant:padding).isActive = true
        mentionButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        mentionButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        mentionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        hashtagButton.topAnchor.constraint(equalTo: mentionButton.bottomAnchor, constant:padding).isActive = true
        hashtagButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        hashtagButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        hashtagButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        searchUserButton.topAnchor.constraint(equalTo: hashtagButton.bottomAnchor, constant:padding).isActive = true
        searchUserButton.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
        searchUserButton.heightAnchor.constraint(equalToConstant: heightbutton).isActive = true
        searchUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
}




