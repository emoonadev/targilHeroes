//
//  Actor.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation
import CoreData

struct Actor: Codable {
    let name: String
    let nickname: String
    let image: String
    let dateOfBirth: Int
    let powers: [String]
    let actorName: String
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nickname = "nickname"
        case image = "image"
        case dateOfBirth = "dateOfBirth"
        case powers = "powers"
        case actorName = "actorName"
        case movies = "movies"
    }
}

