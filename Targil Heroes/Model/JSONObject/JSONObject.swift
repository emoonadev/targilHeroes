//
//  JSONObject.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation

struct JSONObject: Codable {
    let success: Bool
    let errorCode: Int
    let message: String
    let actor: Actor
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case errorCode = "errorCode"
        case message = "message"
        case actor = "actor"
    }
    
    init() {
        let gitUrl = URL(string: "http://heroapps.co.il/employee-tests/ios/logan.json")
        URLSession.shared.dataTask(with: gitUrl!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(JSONObject.self, from: data)
                print(gitData.success)
                print(gitData.actor.actorName)
                print(gitData.actor.movies[0].name)
            } catch let err {
                print("Err", err)
            }
            
            }.resume()
    }
}
