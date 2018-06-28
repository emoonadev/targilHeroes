//
//  Actor.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Actor: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var nickname: String?
    @objc dynamic var image: String?
    @objc dynamic var dateOfBirth: Int = 0
    @objc dynamic var  _powers: String = ""
    var powers: [String]?
    @objc dynamic var actorName: String?

    var movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nickname = "nickname"
        case image = "image"
        case dateOfBirth = "dateOfBirth"
        case powers = "powers"
        case actorName = "actorName"
        case movies = "movies"
    }
    
    convenience init(name: String, nickname: String, image: String, actorName: String, dateOfBirth: Int, powers: [String], movies: [Movie]) {
        self.init()
        self.name = name
        self.nickname = nickname
        self.image = image
        self.powers = powers
        self.actorName = actorName
        self.movies = movies
        self.dateOfBirth = dateOfBirth
        self._powers = powers.joined(separator: ", ")
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let nickname = try container.decode(String.self, forKey: .nickname)
        let image = try container.decode(String.self, forKey: .image)
        let actorName = try container.decode(String.self, forKey: .actorName)
        let dateOfBirth = try container.decode(Int.self, forKey: .dateOfBirth)
        let powers = try container.decode([String].self, forKey: .powers)
        let movies = try container.decode([Movie].self, forKey: .movies)
        self.init(name: name, nickname: nickname, image: image, actorName: actorName, dateOfBirth: dateOfBirth, powers: powers, movies: movies)
    }
}

