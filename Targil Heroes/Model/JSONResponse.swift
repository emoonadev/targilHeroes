//
//  JSONResponse.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation

struct JSONResponse: Codable {
    let actor: Actor
    
    enum CodingKeys: String, CodingKey {
        case actor = "data"
    }
}
