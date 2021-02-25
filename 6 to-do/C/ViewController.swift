//
//  ViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/24.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.20, green: 0.23, blue: 0.36, alpha: 1.0)
        startButton.layer.cornerRadius = 5
    }
    
    

    @IBAction func tapStart(_ sender: Any) {
        performSegue(withIdentifier: "input", sender: nil)
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        
    }
}

