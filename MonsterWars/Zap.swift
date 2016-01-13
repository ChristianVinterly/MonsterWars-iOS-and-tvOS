//
//  Zap.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Zap: GKEntity {
  
  init(team: Team, entityManager: EntityManager) {
    
    super.init()
    
    let texture = SKTexture(imageNamed: "zap\(team.rawValue)")
    let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, barOffset: texture.size().height/2, health: 10, entityManager: entityManager))
    addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width / 2), entityManager: entityManager))
    addComponent(TeamComponent(team: team))
    addComponent(FiringComponent(range: 300, damage: 5, damageRate: 1.5, sound: SoundManager.sharedInstance.soundPew, entityManager: entityManager))
    
  }

}