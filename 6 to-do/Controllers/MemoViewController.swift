//
//  MemoViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/03/14.
//

import UIKit

class MemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TaskMemoCell", bundle: nil), forCellReuseIdentifier: "TaskMemoCell")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskMemoCell", for: indexPath) as! TaskMemoCell
        return cell
    }





}
