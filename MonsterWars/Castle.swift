//
//  Castle.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Castle: GKEntity {

  init(imageName: String, team: Team, entityManager: EntityManager) {
    
    super.init()
    
    let texture = SKTexture(imageNamed: imageName)
    let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: spriteComponent.node.size.width, barOffset: spriteComponent.node.size.height/2, health: 500, entityManager: entityManager))
    addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager))
    addComponent(TeamComponent(team: team))
    addComponent(FiringComponent(range: 200, damage: 5, damageRate: 2.0, sound: SoundManager.sharedInstance.soundPew, entityManager: entityManager))
    addComponent(CastleComponent())

  }
  

}