//
//  HistoryViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/06/20.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    var animationLabel: CountAnimateLabel!
    
    var sumOfCompletion = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: .sumOfCompletionKey)
        setUpViews()
        
        test()
        
    }

    private func setUpViews(){
        self.navigationItem.title = VCType.showSum.navigationTitle
        self.overrideUserInterfaceStyle = .light
        prepareAnimationLabel()
    }
    
    private func prepareAnimationLabel() {
        
        animationLabel = CountAnimateLabel()
        let margin = 30
        let labelWidth = 150
        let labelHeight = 150
        animationLabel.frame = CGRect(x: margin, y: Int(self.view.bounds.height) - labelHeight - margin, width: labelWidth, height: labelHeight)
        animationLabel.textAlignment = .center
        animationLabel.backgroundColor = ProjectColor.sixTodoPurple
        animationLabel.textColor = .black
        animationLabel.font = .boldSystemFont(ofSize: 50)
        animationLabel.textAlignment = .center
        animationLabel.adjustsFontSizeToFitWidth = true
        animationLabel.textColor = .white
        animationLabel.convertCircle(width: labelWidth)
        
        self.view.addSubview(animationLabel)
        animationLabel.animate(from: 0, to: 150, duration: 1.3)
    }
    
    func test() {
        let historyList: [History] = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)
        
    }

}

//extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let historyList: [History] = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)
//
//        
//        let formattedTaskList: [String:[String]] = [:]
//        for history in historyList {
//            if 
//        }
//            
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
//    
//    
//}
