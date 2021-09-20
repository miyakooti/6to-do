//
//  TomorrowModalViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/20.
//

import UIKit

class TomorrowModalViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
        
        rightButton.backgroundColor = ProjectColor.sixTodoPurple
        rightButton.layer.cornerRadius = rightButton.bounds.size.height / 2
        leftButton.layer.cornerRadius = leftButton.bounds.size.height / 2
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @objc func closeButtonDidTapped() {
        self.dismiss(animated: true, completion: nil)
    }


}
