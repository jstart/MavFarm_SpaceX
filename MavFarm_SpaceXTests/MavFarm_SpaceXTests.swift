//
//  MavFarm_SpaceXTests.swift
//  MavFarm_SpaceXTests
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import XCTest
@testable import MavFarm_SpaceX

class MavFarm_SpaceXTests: XCTestCase {
    let decoder = JSONDecoder()

    func testDecodeLaunches() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "upcoming", ofType: "json") else {
            fatalError("upcoming.json not found")
        }
        let data = FileManager.default.contents(atPath: pathString)!
        do {
            let launches = try decoder.decode([Launch].self, from: data)
            XCTAssertNotNil(launches)
            XCTAssertEqual(launches.count, 22)
        } catch {
            print(error)
            XCTFail()
        }
    }
    
    func testDecodeNextLaunch() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "next", ofType: "json") else {
            fatalError("next.json not found")
        }
        let data = FileManager.default.contents(atPath: pathString)!
        do {
            let next = try decoder.decode(Launch.self, from: data)
            XCTAssertNotNil(next)
            XCTAssertEqual(next.flight_number, 82)
        } catch {
            print(error)
            XCTFail()
        }
    }
    
    func testFetchLaunchList() {
        var launches: [Launch]?
        let expectation = self.expectation(description: "Fetch launch list")

        SpaceXClient.fetchUpcomingLaunches(completion: { result in
            switch result {
            case .success(let value):
                launches = value
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        })
    
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(launches?.count, 0)
    }

    func testFetchNextLaunch() {
        var launch: Launch?
        let expectation = self.expectation(description: "Fetch next launch")
        
        SpaceXClient.fetchNextLaunch(completion: { result in
            switch result {
            case .success(let value):
                launch = value
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(launch)
    }
}
