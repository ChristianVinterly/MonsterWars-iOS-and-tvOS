//
//  Munch.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Munch: GKEntity {
  
  init(team: Team, entityManager: EntityManager) {
    
    super.init()
    
    let texture = SKTexture(imageNamed: "munch\(team.rawValue)")
    let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, barOffset: texture.size().height/2, health: 75, entityManager: entityManager))
    addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
    addComponent(TeamComponent(team: team))
    addComponent(MeleeComponent(damage: 15, destroySelf: false, damageRate: 2.5, aoe: true, sound: SoundManager.sharedInstance.soundBigHit, entityManager: entityManager))
    
  }

}