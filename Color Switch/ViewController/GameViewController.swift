//
//  GameViewController.swift
//  Color Switch
//
//  Created by Klemen Brecko on 11/04/2021.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            
            let scene = MenuScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            
            
           
            
        }
    }
}
