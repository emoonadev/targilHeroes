//
//  ItemManager.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation

class ItemManager{
    var delegate: UpdateDelegate?
    
    func getDataFromURL(url: String){
        guard let gitUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Item.self, from: data)
                
                self.delegate?.didUpdate(sender: self, actor: jsonData.actor)
            } catch let err {
                print("Err", err)
            }
            
            }.resume()
    }
}
