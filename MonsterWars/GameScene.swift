//
//  GameScene.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

  // Constants
  let margin = CGFloat(30)
 
  // Buttons
  var quirkButton: ButtonNode!
  var zapButton: ButtonNode!
  var munchButton: ButtonNode!

  // Labels
//  let stateLabel = SKLabelNode(fontNamed: "Courier-Bold")
  let coin1Label = SKLabelNode(fontNamed: "Courier-Bold")
  let coin2Label = SKLabelNode(fontNamed: "Courier-Bold")
  
  // Update time
  var lastUpdateTimeInterval: NSTimeInterval = 0
  
  // Game over detection
  var gameOver = false

  // Entity-component system
  var entityManager: EntityManager!
  
  override func didMoveToView(view: SKView) {
  
    print("scene size: \(size)")
    
    // Create entity manager
    entityManager = EntityManager(scene: self)
  
    // Start background music
    let bgMusic = SKAudioNode(fileNamed: "Latin_Industries.mp3")
    bgMusic.autoplayLooped = true
    addChild(bgMusic)
    
    // Add background
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: size.width/2, y: size.height/2)
    background.zPosition = -1
    addChild(background)
    
    // Add coin 1 indicator
    let coin1 = SKSpriteNode(imageNamed: "coin")
    coin1.position = CGPoint(x: margin + coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
    addChild(coin1)
    coin1Label.fontSize = 50
    coin1Label.fontColor = SKColor.blackColor()
    coin1Label.position = CGPoint(x: coin1.position.x + coin1.size.width/2 + margin, y: coin1.position.y)
    coin1Label.zPosition = 1
    coin1Label.horizontalAlignmentMode = .Left
    coin1Label.verticalAlignmentMode = .Center
    coin1Label.text = "10"
    self.addChild(coin1Label)
    
    // Add coin 2 indicator
    let coin2 = SKSpriteNode(imageNamed: "coin")
    coin2.position = CGPoint(x: size.width - margin - coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
    addChild(coin2)
    coin2Label.fontSize = 50
    coin2Label.fontColor = SKColor.blackColor()
    coin2Label.position = CGPoint(x: coin2.position.x - coin2.size.width/2 - margin, y: coin1.position.y)
    coin2Label.zPosition = 1
    coin2Label.horizontalAlignmentMode = .Right
    coin2Label.verticalAlignmentMode = .Center
    coin2Label.text = "10"
    self.addChild(coin2Label)
    
    // Add castles
    let humanCastle = Castle(imageName: "castle1_def", team: .Team1, entityManager: entityManager)
    if let spriteComponent = humanCastle.componentForClass(SpriteComponent.self) {
      spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
    }
    entityManager.add(humanCastle)

    let aiCastle = Castle(imageName: "castle2_def", team: .Team2, entityManager: entityManager)
    if let spriteComponent = aiCastle.componentForClass(SpriteComponent.self) {
      spriteComponent.node.position = CGPoint(x: size.width - spriteComponent.node.size.width/2, y: size.height/2)
    }
    aiCastle.addComponent(AiComponent(entityManager: entityManager))
    entityManager.add(aiCastle)
    
//    // Test decrease of health
//    runAction(SKAction.repeatActionForever(
//      SKAction.sequence([
//        SKAction.waitForDuration(2),
//        SKAction.runBlock() {
//          self.castle1.healthComponent.takeDamage(5)
//          self.castle2.healthComponent.takeDamage(5)
//        },
//      ])
//    ))
    
  }
  
  func quirkPressed() {
    print("Quirk pressed!")    
    entityManager.spawnQuirk(.Team1)
  }
  
  func zapPressed() {
    print("Zap pressed!")
    entityManager.spawnZap(.Team1)
  }
  
  func munchPressed() {
    print("Munch pressed!")
    entityManager.spawnMunch(.Team1)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    let touchLocation = touch.locationInNode(self)
    print("\(touchLocation)")
    
    if gameOver {
      let newScene = GameScene(size: size)
      newScene.scaleMode = scaleMode
      view?.presentScene(newScene, transition: SKTransition.flipHorizontalWithDuration(0.5))
      return
    }
    
//    if let humanCastle = entityManager.castleForTeam(.Team1),
//           humanCastleComponent = humanCastle.componentForClass(CastleComponent.self) {
//      humanCastleComponent.attacking = !humanCastleComponent.attacking
//      stateLabel.text = humanCastleComponent.attacking ? "Attacking" : "Defending"
//    }
    
    
  }
  
  func showRestartMenu(won: Bool) {
    
    if gameOver {
      return;
    }
    gameOver = true
    
    let message = won ? "You win" : "You lose"
    
    let label = SKLabelNode(fontNamed: "Courier-Bold")
    label.fontSize = 100
    label.fontColor = SKColor.blackColor()
    label.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
    label.zPosition = 1
    label.verticalAlignmentMode = .Center
    label.text = message
    label.setScale(0)
    addChild(label)
    
    let scaleAction = SKAction.scaleTo(1.0, duration: 0.5)
    scaleAction.timingMode = SKActionTimingMode.EaseInEaseOut
    label.runAction(scaleAction)
    
  }
  
 
  override func update(currentTime: CFTimeInterval) {

    let deltaTime = currentTime - lastUpdateTimeInterval
    lastUpdateTimeInterval = currentTime
    
    if gameOver {
      return
    }

    entityManager.update(deltaTime)
    
    // Check for game over
    if let human = entityManager.castleForTeam(.Team1),
           humanCastle = human.componentForClass(CastleComponent.self),
           humanHealth = human.componentForClass(HealthComponent.self) {
      if (humanHealth.health <= 0) {
        showRestartMenu(false)
      }
      coin1Label.text = "\(humanCastle.coins)"
    }
    if let ai = entityManager.castleForTeam(.Team2),
           aiCastle = ai.componentForClass(CastleComponent.self),
           aiHealth = ai.componentForClass(HealthComponent.self) {
      if (aiHealth.health <= 0) {
        showRestartMenu(true)
      }
      coin2Label.text = "\(aiCastle.coins)"
    }
    
  }
}
