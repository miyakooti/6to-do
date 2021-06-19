import UIKit

final class WhatIsViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        
        let height = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        textView.heightAnchor.constraint(equalToConstant: height+100).isActive = true
        myView.layer.cornerRadius = 30
        self.navigationItem.title = VCType.whatIs.navigationTitle
        self.overrideUserInterfaceStyle = .light
    }

}
