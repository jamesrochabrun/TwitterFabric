//
//  UsersCell.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 4/14/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

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
        
        //this labels are provided by default by the cells
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


