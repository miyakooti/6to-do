//
//  WhatIsViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/27.
//

import UIKit

class WhatIsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let height = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        textView.heightAnchor.constraint(equalToConstant: height+100).isActive = true
        myView.layer.cornerRadius = 30
        self.navigationItem.title = "アイビーリーメソッドとは"
        self.overrideUserInterfaceStyle = .light
    }

}
