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
        return view
    }()

    lazy var gradientView: UIView = {
        let gv = UIView()
        gv.frame = self.view.frame
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.hexStringToUIColor(Constants.APPColor.coral).cgColor, UIColor.hexStringToUIColor(Constants.APPColor.purple).cgColor]
        gv.layer.insertSublayer(gradient, at: 0)
        return gv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissView))
        view.addSubview(gradientView)
        view.addSubview(profileView)
        
        if let u = self.user {
            profileView.configureViewWithUser(u)
        }
        print("USER: \(self.user)")
    }

    func dismissView() {
        self.navigationController?.dismiss(animated: true)
    }


}
