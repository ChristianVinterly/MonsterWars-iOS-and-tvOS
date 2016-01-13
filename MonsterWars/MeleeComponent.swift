//
//  MeleeComponent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MeleeComponent: GKComponent {
  
  let damage: CGFloat
  let destroySelf: Bool
  let damageRate: CGFloat
  var lastDamageTime: NSTimeInterval
  let aoe: Bool
  let sound: SKAction
  let entityManager: EntityManager
  
  init(damage: CGFloat, destroySelf: Bool, damageRate: CGFloat, aoe: Bool, sound: SKAction, entityManager: EntityManager) {
    self.damage = damage
    self.destroySelf = destroySelf
    self.damageRate = damageRate
    self.aoe = aoe
    self.sound = sound
    self.lastDamageTime = 0
    self.entityManager = entityManager
    super.init()
  }
  
  override func updateWithDeltaTime(seconds: NSTimeInterval) {
    
    super.updateWithDeltaTime(seconds)
    
    // Get required components
    guard let teamComponent = entity?.componentForClass(TeamComponent.self),
              spriteComponent = entity?.componentForClass(SpriteComponent.self) else {
      return
    }
    
    // Loop through enemy entities
    var aoeDamageCaused = false
    let enemyEntities = entityManager.entitiesForTeam(teamComponent.team.oppositeTeam())
    for enemyEntity in enemyEntities {
      
      // Get required components
      guard let enemySpriteComponent = enemyEntity.componentForClass(SpriteComponent.self),
            let enemyHealthComponent = enemyEntity.componentForClass(HealthComponent.self) else {
        continue
      }
      
      // Check for intersection
      if (CGRectIntersectsRect(spriteComponent.node.calculateAccumulatedFrame(), enemySpriteComponent.node.calculateAccumulatedFrame())) {
        
        // Check damage rate
        if (CGFloat(CACurrentMediaTime() - lastDamageTime) > damageRate) {
          
          // Cause damage
          spriteComponent.node.parent?.runAction(sound)
          if (aoe) {
            aoeDamageCaused = true
          } else {
            lastDamageTime = CACurrentMediaTime()
          }
          
          // Subtract health
          enemyHealthComponent.takeDamage(damage)
          
          // Destroy self
          if destroySelf {
            entityManager.remove(entity!)
          }
        }
      }
    }
    
    if (aoeDamageCaused) {
      lastDamageTime = CACurrentMediaTime()
    }
    
  }
  
}