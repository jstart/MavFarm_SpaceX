//
//  MainViewController.swift
//  MavFarm_SpaceX
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let countdownView = CountdownView()
    var launch: Launch?
    
    let launchTableVC = LaunchTableViewController(style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("HomeTitle", comment: "title for home screen")
        
        view.addSubview(countdownView)
        countdownView.setupLayout()
        
        addChild(launchTableVC)
        view.addSubview(launchTableVC.view)
        launchTableVC.didMove(toParent: self)
        
        countdownView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
            make.width.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        launchTableVC.view.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.width.equalTo(view)
            make.top.equalTo(countdownView.snp.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countdownView.startLoading()
        
        SpaceXClient.fetchNextLaunch(completion: { [weak self] result in
            switch result {
            case .success(let launch):
                self?.launch = launch
                self?.countdownView.configure(launch: launch)
            case .failure(let error):
                let alert = UIAlertController.alert(title: "Error", message: error.localizedDescription)
                self?.present(alert, animated: true)
            }
        })
    }

}
