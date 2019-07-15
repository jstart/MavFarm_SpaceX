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

// MARK: - Launch
struct Launch: Decodable {
    let mission_name: String
    let mission_id: [String]
    let launch_date_local: Date
    let rocket: Rocket
    
    func reusedParts() -> [String] {
        var reusedParts = [String]()
        if rocket.first_stage.cores.first?.reused == true {
            reusedParts.append("First Stage Core")
        }
        if rocket.second_stage.payloads.first?.reused == true {
            reusedParts.append("Second Stage Payload")
        }
        if rocket.fairings?.reused == true {
            reusedParts.append("Fairings")
        }
        return reusedParts
    }
}

// MARK: - Rocket
struct Rocket: Codable {
    let rocket_name: String
    let first_stage: FirstStage
    let second_stage: SecondStage
    let fairings: Fairings?
}

// MARK: - Fairings
struct Fairings: Codable {
    let reused: Bool
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let cores: [Core]
}

// MARK: - Core
struct Core: Codable {
    let reused: Bool?
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let block: Int?
    let payloads: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    let reused: Bool
}

enum ClientError: Error {
    case decodeFailure
}

// MARK: - Client
struct SpaceXClient {
    
    static let base = "https://api.spacexdata.com/v3/launches/"
    static let next = "next", upcoming = "upcoming"

    static func fetchUpcomingLaunches(completion: @escaping LaunchListHandler) {
        fetch(urlString: base + upcoming, completion: { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let upcoming = try? decoder.decode([Launch].self, from: data) else {
                    completion(.failure(ClientError.decodeFailure))
                    return
                }

                completion(.success(upcoming))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    static func fetchNextLaunch(completion: @escaping LaunchHandler) {
        fetch(urlString: base + next, completion: { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let next = try? decoder.decode(Launch.self, from: data) else {
                    completion(.failure(ClientError.decodeFailure))
                    return
                }
                
                completion(.success(next))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    fileprivate static func fetch(urlString: String, completion: @escaping (Alamofire.DataResponse<Data>) -> Void) {
        Alamofire.request(urlString)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData(completionHandler: completion)
    }
}
