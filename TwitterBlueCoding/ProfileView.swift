//
//  ProfileView.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.frame.size.width/4
        return imageView
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.text = "hellloooooof;kjvbv;jkb ;br ;rb;jrb "
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.centerXAnchor.constraint(equalTo: (self.centerXAnchor)).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: (self.centerYAnchor)).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: (self.heightAnchor), multiplier: 1/2).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: (self.widthAnchor), multiplier: 1/2).isActive = true
        labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        labelName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.addSubview(profileImageView)
        self.addSubview(labelName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
