//
//  MenuScene.swift
//  Color Switch
//
//  Created by Klemen Brecko on 11/04/2021.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        addLogo()
        addLabels()
        
    }
    
    func addLogo(){
        
        let logo = SKSpriteNode(imageNamed: "ColorCircle")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.maxY - logo.size.height)
        
        addChild(logo)
        
    }
    func addLabels(){
        let playLabel = SKLabelNode(text: "Nova igra")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 40.0
        playLabel.fontColor = UIColor.systemPurple
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        
        
        let highScoreLbl = SKLabelNode(text: "Najvišji rezultat:" + "\(UserDefaults.standard.integer(forKey: "Najvišji rezultat"))")
        highScoreLbl.fontName = "AvenirNext-Bold"
        highScoreLbl.fontSize = 30.0
        highScoreLbl.fontColor = UIColor.systemRed
        highScoreLbl.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLbl.frame.size.height * 1.5)
        addChild(highScoreLbl)
        
        
        let recentScoreLbl = SKLabelNode(text: "Zadnji rezultat: " + "\(UserDefaults.standard.integer(forKey: "Trenutni rezultat"))")
        recentScoreLbl.fontName = "AvenirNext-Bold"
        recentScoreLbl.fontSize = 30.0
        recentScoreLbl.fontColor = UIColor.systemYellow
        recentScoreLbl.position = CGPoint(x: frame.midX, y: highScoreLbl.position.y - recentScoreLbl.frame.size.height * 2)
        addChild(recentScoreLbl)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        
        view!.presentScene(gameScene)
        
    }
    
}
