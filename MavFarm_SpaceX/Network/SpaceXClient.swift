//
//  SpaceXClient.swift
//  MavFarm_SpaceX
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation
import Alamofire

typealias LaunchListHandler = (Result<[Launch]>) -> Void
typealias LaunchHandler = (Result<Launch>) -> Void

struct Launch: Decodable {
    var flight_number: Int
    var mission_name: String
    var details: String?
}

enum ClientError: Error {
    case generic
}

struct SpaceXClient {
    static func fetchUpcomingLaunches(completion: @escaping LaunchListHandler) {
        completion(.failure(ClientError.generic))
    }
    
    static func fetchNextLaunch(completion: @escaping LaunchHandler) {
        completion(.failure(ClientError.generic))
    }
}
