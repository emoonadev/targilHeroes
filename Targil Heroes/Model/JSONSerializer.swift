//
//  JSONSerializer.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 27/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation
import RealmSwift

//class JSONSerializer {
//    func serialize(input sourceName: String) {
//        let path = Bundle.main.path(forResource: sourceName, ofType: nil)
//        let url = URL(fileURLWithPath: path!)
//        let jsonDecoder = JSONDecoder()
//        do {
//            let data = try Data(contentsOf: url)
//            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            guard json is [AnyObject] else {
//                assert(false, "failed to parse")
//                return
//            }
//            do {
//                let cats = try jsonDecoder.decode([Item].self, from: data)
//                let realm = try! Realm()
//                for cat in cats {
//                    try! realm.write {
//                        realm.add(cat as Object)
//                    }
//                }
//            } catch {
//                print("failed to convert data")
//            }
//        } catch let error {
//            print(error)
//        }
//    }
//}
