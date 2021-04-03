//
//  TwitterViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/27.
//

import UIKit

class TwitterViewController: UIViewController {

    @IBOutlet weak var twitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction func tapTwitter(_ sender: Any) {
        let url = URL(string: "https://twitter.com/karai_shan")
        //UIApplication.shared.openURL(url!)
        // iOS 10以降利用可能
        UIApplication.shared.open(url!)
    }
    
    func setUpView() {
        self.navigationItem.title = "twitter"
        self.overrideUserInterfaceStyle = .light
        twitterButton.layer.cornerRadius = 10
        twitterButton.layer.shadowColor = UIColor.black.cgColor
        twitterButton.layer.shadowRadius = 10
        twitterButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        twitterButton.layer.shadowOpacity = 0.2
    }
    
}
