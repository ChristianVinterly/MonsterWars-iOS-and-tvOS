//
//  Quirk.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Quirk: GKEntity {
  
  init(team: Team, entityManager: EntityManager) {
    
    super.init()
    
    let texture = SKTexture(imageNamed: "quirk\(team.rawValue)")
    let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, barOffset: texture.size().height/2, health: 15, entityManager: entityManager))
    addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
    addComponent(TeamComponent(team: team))
    addComponent(MeleeComponent(damage: 2.5, destroySelf: false, damageRate: 0.5, aoe: false, sound: SoundManager.sharedInstance.soundSmallHit, entityManager: entityManager))
    
  }

}