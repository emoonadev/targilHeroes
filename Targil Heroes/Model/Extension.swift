//
//  Extension.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension UIImageViewX {
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}

extension Results {
    func toArray() -> [Any] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    func toArray() -> [Any] {
        return self.map{$0}
    }
}

