//
//  PictureZoomController.swift
//  Targil Heroes
//
//  Created by Mickael Belhassen on 26/06/2018.
//  Copyright © 2018 EmoonaDev. All rights reserved.
//

import UIKit

class PictureZoomController: UIViewController {

    @IBOutlet weak var picture: UIImageViewX!
    
    var receivePic: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picture.isUserInteractionEnabled = true
        picture.image = receivePic
        
        //Create pinch gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        //Add pinch gesture to imageview
        picture.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer){
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }
    
    @IBAction func closePicture(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
