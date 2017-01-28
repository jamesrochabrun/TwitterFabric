//
//  ProfileVCViewController.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import TwitterKit

class ProfileVC: UIViewController {
    
    var user: TWTRUser?
    lazy var profileView: ProfileView = {
        let view = ProfileView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        view.center = self.view.center
        view.backgroundColor = UIColor.blue
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        
        print("USER: \(self.user)")

    }



}
