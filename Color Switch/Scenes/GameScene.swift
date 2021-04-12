//
//  GameScene.swift
//  Color Switch
//
//  Created by Klemen Brecko on 11/04/2021.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 67/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchState: Int{
    case red, yellow, green, blue
}

class GameScene: SKScene {

    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    
    let ball = SKSpriteNode(imageNamed: "ball")
    
    
    var score: Int = 0
    let scoreLbl = SKLabelNode(text: "0")
    
    let gameOverLbl = SKLabelNode(text: "Igre je konec!")
    
    
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()
        
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        physicsWorld.contactDelegate = self
    }
    
    func setupPhysicsLevel2(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)
        physicsWorld.contactDelegate = self
    }
    func setupPhysicsLevel3(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
    }
    func setupPhysicsLevel4(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.5)
        physicsWorld.contactDelegate = self
    }
    func setupPhysicsLevel5(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        physicsWorld.contactDelegate = self
    }
    func setupPhysicsLevel6(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.5)
        physicsWorld.contactDelegate = self
    }
    func setupPhysicsLevel7(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -4.0)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        
        addChild(colorSwitch)
        scoreLbl.fontName = "AvenirNext-Bold"
        scoreLbl.fontSize = 45.0
        scoreLbl.fontColor = UIColor.white
        scoreLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLbl.zPosition = ZPositions.label
        addChild(scoreLbl)
        
        
        
        spawnBall()
        
    }
    
    func updateScoreLabel(){
        scoreLbl.text = "\(score)"
    }
    
    func spawnBall(){
        
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - 15.0)
        ball.zPosition = ZPositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    
    func turnWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue + 1)
        {
            switchState = newState
        }else{
            switchState = .red
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
        
    }

    func gameOver(){
        
        UserDefaults.standard.set(score, forKey: "Trenutni rezultat")
        if score > UserDefaults.standard.integer(forKey: "Najvišji rezultat"){
            UserDefaults.standard.set(score, forKey: "Najvišji rezultat")
        }
        
        gameOverLbl.fontName = "AvenirNext-Bold"
        gameOverLbl.fontColor = UIColor.red
        gameOverLbl.fontSize = 40.0
        gameOverLbl.position = CGPoint(x: frame.midX, y: frame.midY + 60)
        gameOverLbl.zPosition = ZPositions.label
        addChild(gameOverLbl)
        
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            let openMenu = MenuScene(size: self.view!.bounds.size)
            
            self.view?.presentScene(openMenu)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
        
    }
    
    func levelChange(){
        
        let stopnja2 = SKLabelNode(text: "Stopnja 2")
        let stopnja3 = SKLabelNode(text: "Stopnja 3")
        let stopnja4 = SKLabelNode(text: "Stopnja 4")
        let stopnja5 = SKLabelNode(text: "Stopnja 5")
        let stopnja6 = SKLabelNode(text: "Stopnja 6")
        let stopnja7 = SKLabelNode(text: "Stopnja 7")
        
        
        if score == 10 {
            setupPhysicsLevel2()
            
            
            stopnja2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
            stopnja2.fontName = "AvenirNext-Bold"
            stopnja2.fontSize = 25
            stopnja2.fontColor = UIColor.green
            addChild(stopnja2)
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                stopnja2.removeFromParent()
            }
        }
        else if score == 20{
            setupPhysicsLevel3()
            
            stopnja3.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
            stopnja3.fontName = "AvenirNext-Bold"
            stopnja3.fontSize = 25
            stopnja3.fontColor = UIColor.green
            addChild(stopnja3)
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                stopnja3.removeFromParent()
            }
            
        }
        else if score == 30{
            setupPhysicsLevel4()
            
            stopnja4.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
            stopnja4.fontName = "AvenirNext-Bold"
            stopnja4.fontSize = 25
            stopnja4.fontColor = UIColor.green
            addChild(stopnja4)
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                stopnja4.removeFromParent()
            }
            
        }
        else if score == 40{
            setupPhysicsLevel5()
            
            stopnja5.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
            stopnja5.fontName = "AvenirNext-Bold"
            stopnja5.fontSize = 25
            stopnja5.fontColor = UIColor.green
            addChild(stopnja5)
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                stopnja5.removeFromParent()
            }
            
        }
        else if score == 50{
            setupPhysicsLevel6()
            
            
            stopnja6.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
            stopnja6.fontName = "AvenirNext-Bold"
            stopnja6.fontSize = 25
            stopnja6.fontColor = UIColor.green
            addChild(stopnja6)
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                stopnja6.removeFromParent()
            }
        }
        else if score == 60{
            setupPhysicsLevel7()
            
            
            stopnja7.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
            stopnja7.fontName = "AvenirNext-Bold"
            stopnja7.fontSize = 25
            stopnja7.fontColor = UIColor.green
            addChild(stopnja7)
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                stopnja7.removeFromParent()
            }
        }
        
    }
    
}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory{
            
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue{
                    
                    score += 1
                    updateScoreLabel()
                    levelChange()
                    ball.run(SKAction.fadeOut(withDuration: 0.25)) {
                        ball.removeFromParent()
                        self.spawnBall()
                    }
                    
                }else{
                    gameOver()
                }
            }
            
        }
        
    }
}
