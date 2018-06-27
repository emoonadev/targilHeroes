//
//  ViewController.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import UIKit
import Foundation

protocol UpdateDelegate {
    func didUpdate(sender: ItemManager, actor: Actor)
}

class ViewController: UIViewController, UpdateDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profilePic: UIImageViewX!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var yearBornLabel: UILabel!
    @IBOutlet weak var powersLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleBar: UINavigationItem!
    
    
    let itemManager = ItemManager()
    var actor: Actor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewInitializer()
        itemManagerInitializer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didUpdate(sender: ItemManager, actor: Actor){
        DispatchQueue.main.async() {
            self.actor = actor
            self.titleBar.title = actor.name
            
            //set Actor picture
            self.profilePic.setCustomImage(actor.image)
            self.profilePic.layer.masksToBounds = true
        
            //Set actor info
            self.nickNameLabel.text = actor.nickname
            self.yearBornLabel.text = String(actor.dateOfBirth)
            self.powersLabel.text = actor.powers.joined(separator: ", ")
            self.actorLabel.text = actor.actorName
        
        
            self.tableView.reloadData()
        }
    }
    
    func itemManagerInitializer() {
        itemManager.delegate = self
        itemManager.getDataFromURL(url: "http://heroapps.co.il/employee-tests/ios/logan.json")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicZoom" {
            let vcPicZoom: PictureZoomController = segue.destination as! PictureZoomController
            
            vcPicZoom.receivePic = profilePic.image
        }
    }
    
    //--------TABLE VIEW------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return actor?.movies.count ?? 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        cell?.selectionStyle = .none //remove higlighting of cell
        cell?.view(with: actor!.movies[indexPath.row])
        
        return cell!
    }
    
    func tableViewInitializer() {
        tableView.dataSource = self; //Initialize table view
        tableView.separatorStyle = .none //remove separator line
    }
    
    //------------------------
}
