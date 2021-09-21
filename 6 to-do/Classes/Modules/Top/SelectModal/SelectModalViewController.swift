//
//  SelectModalViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/21.
//

import UIKit

protocol CatchModalActionDelegate {
    func catchModalAction()
}

class SelectModalViewController: UIViewController {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var titleText = ""
    
    var delegate: CatchModalActionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        rightButton.addTarget(self, action: #selector(rightButtonDidTapped), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(leftButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func rightButtonDidTapped() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .modalClosed, object: nil)
        delegate?.catchModalAction()
    }
    
    @objc func leftButtonDidTapped() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .modalClosed, object: nil)
    }
    
    private func setUpViews() {
        titleLabel.text = titleText
        rightButton.backgroundColor = ProjectColor.sixTodoPurple
        rightButton.layer.cornerRadius = rightButton.bounds.size.height / 2
        leftButton.layer.cornerRadius = leftButton.bounds.size.height / 2
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
