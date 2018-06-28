//
//  ItemManager.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import Foundation
import RealmSwift

class ItemManager{
    var delegate: UpdateDelegate?
    var actors: [Actor]?
    
    func getDataFromURL(url: String){
        guard let gitUrl = URL(string: url) else { return } //I convert the string to URL
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Item.self, from: data) //I will use JSONDecoder, to decode my main object
                
                //I return the information of the actor to recover to the view controller for display
                self.delegate?.didUpdate(sender: self, actor: jsonData.actor)
                
                
                /*Now we will take care of saving the objects in the Realm database*/
                DispatchQueue.main.async {
                    //We check that the actor does not exist because if it exists it will create a duplicate.
                    if (!(self.actors?.isEmpty)!){
                        if (self.actors?.contains(where: {$0.actorName! == jsonData.actor.actorName}))!{
                            print("Actor allready exist in database!")
                            return
                        }
                    }
                    
                    //We saving the actor in Realm
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(jsonData.actor)
                        
                        //We record all the movie from the array of movie in Realm
                        for movie in jsonData.actor.movies!{
                            movie.actor = jsonData.actor.actorName!
                            realm.add(movie)
                        }
                    }
                    
                }
            } catch let err {
                print("Error", err)
            }
            
            }.resume()
    }
    
    func retrieveAllData(){
        self.actors?.removeAll()
        
        do {
            /*
             I will retrieve all the Actors and Movies objects that are in the Realm database.
             (I prefer to recover all the objects because it is more generics,
             if for example we had many actors then it will have filled our array)
            */
            let realm = try Realm()
            self.actors = realm.objects(Actor.self).toArray() as? [Actor] //I use an extension that returns the result in array
            let movies = realm.objects(Movie.self).toArray() as! [Movie] //I use an extension that returns the result in array
            
            
            //I use the loop because I chose to use a generic method for cases where we had a lot of actors ...
            for actor in self.actors!{
                //I now ask swift to take the board of all the movies and filter all the movies that include the name of the actor
                actor.movies = movies.filter{ ($0.actor == actors![0].actorName!) }
            }
            
        } catch let err {
            print("Error", err)
        }
    }
}
