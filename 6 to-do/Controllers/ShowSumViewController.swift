import UIKit

final class ShowSumViewController: UIViewController {
    
    var label: CountAnimateLabel!
    
    var sumOfCompletion = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: "sumOfCompletion")
        setUpViews()
    }

    private func setUpViews(){
        self.navigationItem.title = "これまでに完了したタスクの数"
        self.overrideUserInterfaceStyle = .light
        
        label = CountAnimateLabel()
        let labelWidth = 200
        let labelHeight = 100
        label.frame = CGRect(x: (Int(view.frame.size.width) - labelWidth) / 2 , y: (Int(view.frame.size.height) - labelHeight) / 2, width: labelWidth, height: labelHeight)
        label.textColor = .black
        label.textAlignment = .center
        label.font = label.font.withSize(100)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        label.animate(from: 0, to: sumOfCompletion, duration: 1)
    }

}
