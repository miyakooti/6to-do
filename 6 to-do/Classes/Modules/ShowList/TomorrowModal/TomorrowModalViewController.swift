//
//  TomorrowModalViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/20.
//

import UIKit

protocol catchDataFromModal {
    func catchData(isChecked: Bool)
}

class TomorrowModalViewController: UIViewController {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkBox: CheckBox!
    
    var delegate: catchDataFromModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        leftButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonDidTapped), for: .touchUpInside)
        rightButton.backgroundColor = ProjectColor.sixTodoPurple
        rightButton.layer.cornerRadius = rightButton.bounds.size.height / 2
        leftButton.layer.cornerRadius = leftButton.bounds.size.height / 2
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        checkBox.addTarget(self, action: #selector(checkBoxDidTapped(_:)), for: .touchUpInside)
    }
    
    @objc func rightButtonDidTapped() {
        UserDefaults.standard.setValue(checkBox.isChecked, forKey: .checkBoxStateKey)
        delegate?.catchData(isChecked: checkBox.isChecked)
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .tomorrowModalDidClosed, object: nil)
        NotificationCenter.default.post(name: .tomorrowModalYes, object: nil)
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .tomorrowModalDidClosed, object: nil)
    }
    
    @objc func checkBoxDidTapped(_ sender: CheckBox) {
        sender.reverseState()
    }
    
}
