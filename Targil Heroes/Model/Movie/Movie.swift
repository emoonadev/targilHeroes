//
//  Movie.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Movie: Object, Codable {
    @objc dynamic var name: String = "name"
    @objc dynamic var year: Int = 0
    @objc dynamic var actor: String = "actorName"
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case year = "year"
    }
    
    convenience init(name: String, year: Int) {
        self.init()
        self.name = name
        self.year = year
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let year = try container.decode(Int.self, forKey: .year)
        self.init(name: name, year: year)
    }
}
