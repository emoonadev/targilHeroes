//
//  Movie.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let name: String
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case year = "year"
    }
}
