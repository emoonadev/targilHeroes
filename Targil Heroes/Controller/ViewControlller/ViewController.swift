//
//  ViewController.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//po Realm.Configuration.defaultConfiguration.fileURL


import UIKit
import Foundation
import RealmSwift

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
    private var finishedLoadingInitialTableCells = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewInitializer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemManagerInitializer()
    }
    
    func didUpdate(sender: ItemManager, actor: Actor){
        DispatchQueue.main.async() {
            self.updateInfo(actor: actor)
        }
    }
    
    func updateInfo(actor: Actor){
        self.actor = actor
        self.titleBar.title = actor.name
        
        //set Actor picture
        self.profilePic.setCustomImage(actor.image)
        self.profilePic.layer.masksToBounds = true
        
        //Set actor info
        self.nickNameLabel.text = actor.nickname
        self.yearBornLabel.text = String(actor.dateOfBirth)
        self.powersLabel.text = actor._powers
        self.actorLabel.text = actor.actorName
        
        self.tableView.reloadData()
    }
    
    func itemManagerInitializer() {
        itemManager.delegate = self
        itemManager.retrieveAllData()
        
        
        //checking the internet connection
        if !Reachability.isConnectedToNetwork(){
            if (itemManager.actors?.isEmpty)!{
                //creer un popup pour simuler le offline
                let alert = UIAlertController(title: "Error", message: "You do not have an internet connection, and you have never created the offline database. To create a local database you have to go back at least once with an internet connection so that you can record", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok and close App", style: .default, handler: { action in
                    exit(0) //close the application
                }))
                
                self.present(alert, animated: true, completion: nil)
                
                return
            }else{
                self.updateInfo(actor: self.itemManager.actors![0])
                return
            }
        }
        
        
        if (itemManager.actors?.isEmpty)!{
            itemManager.getDataFromURL(url: "http://heroapps.co.il/employee-tests/ios/logan.json")
        }else{
            //Alertdialog to propose to the user if he wants to make an offline simulation of the application
            let alert = UIAlertController(title: "Simulate Offline service", message: "Do you want to simulate an offline connection and retrieve information from the internal database?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                self.itemManager.getDataFromURL(url: "http://heroapps.co.il/employee-tests/ios/logan.json")
            }))
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.updateInfo(actor: self.itemManager.actors![0])
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicZoom" {
            let vcPicZoom: PictureZoomController = segue.destination as! PictureZoomController
            
            vcPicZoom.receivePic = profilePic.image //We pass the image to the second viewcontroller
        }
    }
    
    //--------TABLE VIEW------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return actor?.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        cell?.selectionStyle = .none //remove higlighting of cell
        cell?.view(with: actor!.movies![indexPath.row])
        
        return cell!
    }
    
    func tableViewInitializer() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none //remove separator line
    }
    
    //below allows to give an animation to the item of the tableview, that they appear one after the other
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var lastInitialDisplayableCell = false
        
        //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
        if actor?.movies?.count ?? 0 > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                lastInitialDisplayableCell = true
            }
        }
        
        if !finishedLoadingInitialTableCells {
            
            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }
            
            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: tableView.rowHeight/2)
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: (0.1 * Double(indexPath.row)), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
    //------------------------
}
