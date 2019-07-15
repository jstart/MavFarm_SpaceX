//
//  CountdownView.swift
//  MavFarm_SpaceX
//
//  Created by Truman, Christopher on 7/15/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class CountdownView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let heading = UILabel(), countdownLabel = UILabel()
    var countdownDate: Date?
    var timer: Timer?
    
    func setupLayout() {
        addSubview(heading)
        heading.alpha = 0.0
        heading.textAlignment = .center
        heading.font = .systemFont(ofSize: 16, weight: .regular)
        heading.text = "Next Launch in:"
        
        addSubview(countdownLabel)
        countdownLabel.alpha = 0.0
        countdownLabel.numberOfLines = 2
        countdownLabel.textAlignment = .center
        countdownLabel.font = .systemFont(ofSize: 30, weight: .bold)
        countdownLabel.adjustsFontSizeToFitWidth = true
        
        let stack = UIStackView(heading, countdownLabel, axis: .vertical, spacing: 5)
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(80)
        }
    }
    
    func startLoading() {
        backgroundColor = .lightGray

        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        activityIndicator.startAnimating()
    }

    func configure(launch: Launch) {
        self.countdownDate = launch.launch_date_local
        
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.updateCountdown()

            self.heading.alpha = 1.0
            self.countdownLabel.alpha = 1.0
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCountdown), userInfo: nil, repeats: true)
        })
    }
    
    @objc func updateCountdown() {
        guard let date = countdownDate else { return }
        let diff = Calendar.autoupdatingCurrent.dateComponents([.day, .hour, .minute, .second], from: Date(), to: date)
        
        let day = "\(diff.day ?? 0) Day\(diff.day == 1 ? "" : "s"), "
        let hour = "\(diff.hour ?? 0) Hour\(diff.hour == 1 ? "" : "s")\n"
        let minute = "\(diff.minute ?? 0) Minute\(diff.minute == 1 ? "" : "s"), "
        let second = "\(diff.second ?? 0) Second\(diff.second == 1 ? "" : "s")"

        countdownLabel.text = day + hour + minute + second
    }

}
