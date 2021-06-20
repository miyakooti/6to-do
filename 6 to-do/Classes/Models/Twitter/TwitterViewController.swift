import UIKit

final class TwitterViewController: UIViewController {

    @IBOutlet private weak var twitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction private func tapTwitter(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/karai_shan") else { return }
        //UIApplication.shared.openURL(url!)
        // iOS 10以降利用可能
        UIApplication.shared.open(url)
    }
    
    private func setUpView() {
        self.navigationItem.title = VCType.twitter.navigationTitle
        self.overrideUserInterfaceStyle = .light
        twitterButton.layer.cornerRadius = 10
        twitterButton.layer.shadowColor = UIColor.black.cgColor
        twitterButton.layer.shadowRadius = 10
        twitterButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        twitterButton.layer.shadowOpacity = 0.2
    }
    
}
