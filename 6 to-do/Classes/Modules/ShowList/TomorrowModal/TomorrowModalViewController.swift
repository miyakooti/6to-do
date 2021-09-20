//
//  TomorrowModalViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/20.
//

import UIKit

class TomorrowModalViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonDidTapped() {
        self.dismiss(animated: true, completion: nil)
    }


}
