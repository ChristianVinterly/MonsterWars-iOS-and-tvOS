//
//  Lasser.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Laser: GKEntity {

  init(team: Team, damage: CGFloat, entityManager: EntityManager) {
    
    super.init()
    
    let texture = SKTexture(imageNamed: "laser\(team.rawValue)")
    let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(TeamComponent(team: team))
    addComponent(MeleeComponent(damage: damage, destroySelf: true, damageRate: 1.0, aoe: false, sound: SoundManager.sharedInstance.soundSmallHit, entityManager: entityManager))

  }
  

}