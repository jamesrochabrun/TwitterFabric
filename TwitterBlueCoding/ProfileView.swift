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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = self.frame.size.width/4
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(handleTapOnImageView)))
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

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: (self.widthAnchor), multiplier: 1/2).isActive = true
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        labelName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImageView)
        self.addSubview(labelName)
    }
    
    func handleTapOnImageView() {
        delegate.showVC()
    }
    
    func turnOffGestureTap() {
        self.profileImageView.isUserInteractionEnabled = false
    }
    
    open func configureViewWithUser(_ user:TWTRUser) {
        
        labelName.text = user.name
        profileImageView.loadImageUsingCacheWithURLString(user.profileImageLargeURL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
