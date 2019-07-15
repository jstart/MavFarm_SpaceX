//
//  LaunchTableViewCell.swift
//  MavFarm_SpaceX
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    let name = UILabel(), time = UILabel(), missionID = UILabel(), rocketName = UILabel(), reused = UILabel()
    
    var stack: UIStackView?
    var launch: Launch?
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        stack?.removeFromSuperview()
        
        if traitCollection.horizontalSizeClass == .compact {
            let stack = UIStackView(name, rocketName, missionID, time, reused, axis: .vertical, spacing: 5)
            contentView.addSubview(stack)
            
            stack.snp.makeConstraints { make in
                make.leading.equalTo(contentView.snp.leadingMargin)
                make.trailing.equalTo(contentView.snp.trailingMargin)
                make.top.equalTo(contentView).offset(10)
                make.bottom.equalTo(contentView).offset(-10)
            }
        }
        
        if traitCollection.horizontalSizeClass == .regular {
            let leftVStack = UIStackView(name, rocketName, missionID, time, axis: .vertical, spacing: 5)
            let stack = UIStackView(leftVStack, UIStackView(reused, axis: .vertical, spacing: 5), axis: .horizontal, spacing: 15)
            contentView.addSubview(stack)
            
            stack.snp.makeConstraints { make in
                make.leading.equalTo(contentView.snp.leadingMargin)
                make.trailing.equalTo(contentView.snp.trailingMargin)
                make.top.equalTo(contentView).offset(10)
                make.bottom.equalTo(contentView).offset(-10)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleLabels()
    }
    
    func styleLabels() {
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        
        rocketName.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        missionID.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        time.font = UIFont.preferredFont(forTextStyle: .footnote)
        time.textColor = .gray
        
        reused.font = UIFont.preferredFont(forTextStyle: .subheadline)
        reused.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(forLaunch launch: Launch, formatter: DateFormatter) {
        self.launch = launch
        
        name.text = launch.mission_name
        time.text = formatter.string(from: launch.launch_date_local)
        missionID.text = launch.mission_id.first
        rocketName.text = launch.rocket.rocket_name
        let reusedParts = launch.reusedParts()

        if reusedParts.count > 0 {
            reused.text = "\nReused Component\(reusedParts.count == 1 ? "" : "s"):\n" + launch.reusedParts().reduce("", { $0 + "\n" + $1 })
        }
    }
    
}
