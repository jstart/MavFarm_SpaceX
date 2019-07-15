//
//  MavFarm_SpaceXUITests.swift
//  MavFarm_SpaceXUITests
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import XCTest

class MavFarm_SpaceXUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testLaunch() {
        XCUIApplication().tables.firstMatch.swipeDown()
    }

}
