//
//  FiringComponent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class FiringComponent: GKComponent {
  
  let range: CGFloat
  let damage: CGFloat
  let damageRate: CGFloat
  var lastDamageTime: NSTimeInterval
  let sound: SKAction
  let entityManager: EntityManager
  
  init(range: CGFloat, damage: CGFloat, damageRate: CGFloat, sound: SKAction, entityManager: EntityManager) {
    self.range = range
    self.damage = damage
    self.damageRate = damageRate
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
    let enemyEntities = entityManager.entitiesForTeam(teamComponent.team.oppositeTeam())
    for enemyEntity in enemyEntities {
      
      // Get required components
      guard let enemySpriteComponent = enemyEntity.componentForClass(SpriteComponent.self) else {
        continue
      }
      
      let distance = (spriteComponent.node.position - enemySpriteComponent.node.position).length()
      let wiggleRoom = CGFloat(5)
      if (CGFloat(abs(distance)) <= range + wiggleRoom && CGFloat(CACurrentMediaTime() - lastDamageTime) > damageRate) {
      
        spriteComponent.node.parent?.runAction(sound)
        lastDamageTime = CACurrentMediaTime()
        
        let laser = Laser(team: teamComponent.team, damage: damage, entityManager: entityManager)
        guard let laserSpriteComponent = laser.componentForClass(SpriteComponent.self) else {
          continue
        }
        
        laserSpriteComponent.node.position = spriteComponent.node.position
        let direction = (enemySpriteComponent.node.position - spriteComponent.node.position).normalized()
        let laserPointsPerSecond = CGFloat(300)
        let laserDistance = CGFloat(1000)
        
        let target = direction * laserDistance
        let duration = laserDistance / laserPointsPerSecond
        
        laserSpriteComponent.node.zRotation = direction.angle
        laserSpriteComponent.node.zPosition = 1
        
        laserSpriteComponent.node.runAction(SKAction.sequence([
          SKAction.moveByX(target.x, y: target.y, duration: NSTimeInterval(duration)),
          SKAction.runBlock() {
            self.entityManager.remove(laser)
          }
        ]))
        
        entityManager.add(laser)
      
      }
      
    }
    
    
  }
  
}