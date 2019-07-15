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
    case decodeFailure
}

struct SpaceXClient {
    
    static let base = "https://api.spacexdata.com/v3/launches/"
    static let next = "next", upcoming = "upcoming"
    static let decoder = JSONDecoder()

    static func fetchUpcomingLaunches(completion: @escaping LaunchListHandler) {
        fetch(urlString: base + upcoming, completion: { response in
            switch response.result {
            case .success(let data):
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
