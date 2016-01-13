//
//  CastleComponent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CastleComponent: GKComponent {  

  var attacking = true
  var coins = 0
  var lastCoinDrop = NSTimeInterval(0)

  override init() {
    super.init()
  }
  
  override func updateWithDeltaTime(seconds: NSTimeInterval) {
    
    super.updateWithDeltaTime(seconds)
    
    // Handle coins
    let coinDropInterval = NSTimeInterval(0.5)
    let coinsPerInterval = 10
    if (CACurrentMediaTime() - lastCoinDrop > coinDropInterval) {
      lastCoinDrop = CACurrentMediaTime()
      coins += coinsPerInterval
    }
    
    // Update player image
    if let spriteComponent = entity?.componentForClass(SpriteComponent.self),
      teamComponent = entity?.componentForClass(TeamComponent.self) {
      if attacking {
        spriteComponent.node.texture = SKTexture(imageNamed: "castle\(teamComponent.team.rawValue)_atk")
      } else {
        spriteComponent.node.texture = SKTexture(imageNamed: "castle\(teamComponent.team.rawValue)_def")
      }
    }
    
  }
  
}