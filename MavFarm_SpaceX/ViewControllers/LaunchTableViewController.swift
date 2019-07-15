//
//  LaunchTableViewController.swift
//  MavFarm_SpaceX
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class LaunchTableViewController: UITableViewController {

    var launches = [Launch]()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(LaunchTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.allowsSelection = false
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SpaceXClient.fetchUpcomingLaunches(completion: { [weak self] result in
            switch result {
            case .success(let launches):
                self?.launches = launches
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController.alert(title: "Error", message: error.localizedDescription)
                self?.present(alert, animated: true)
            }
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(LaunchTableViewCell.self, indexPath: indexPath)
        cell.configure(forLaunch: launches[indexPath.row], formatter: dateFormatter)
        return cell
    }
    
}
