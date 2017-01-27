//
//  ProfileView.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit


protocol ProfileViewDelegate {
    func showVC()
}

class ProfileView: UIView {
    
    var delegate: ProfileViewDelegate! = nil
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = self.frame.size.width/4
        return imageView
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Followers", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(showFollowers), for: .touchUpInside)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: (self.widthAnchor), multiplier: 1/2).isActive = true
        followersButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        followersButton.bottomAnchor.constraint(equalTo: profileImageView.topAnchor, constant: -10).isActive = true
        followersButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        labelName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImageView)
        self.addSubview(labelName)
        self.addSubview(followersButton)
    }
    
    func showFollowers() {
        delegate.showVC()
    }
    
    open func configureViewWithUser(_ user:TWTRUser) {
        
        labelName.text = user.name
        profileImageView.loadImageUsingCacheWithURLString(user.profileImageLargeURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
