//
//  AiComponent.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import GameplayKit

enum MonsterType {
  case Quirk
  case Zap
  case Munch

  static let allValues = [Quirk, Zap, Munch]

}

class AiComponent: GKComponent {

  var nextMonster = MonsterType.Quirk
  let entityManager: EntityManager
  
  init(entityManager: EntityManager) {
    self.entityManager = entityManager
    super.init()
  }

  override func updateWithDeltaTime(seconds: NSTimeInterval) {
  
    // Get required components
    guard let teamComponent = entity?.componentForClass(TeamComponent.self),
              castleComponent = entity?.componentForClass(CastleComponent.self) else {
      return
    }
    
    if nextMonster == .Quirk && castleComponent.coins >= costQuirk {
      entityManager.spawnQuirk(teamComponent.team)
      nextMonster = MonsterType.allValues[Int(arc4random()) % MonsterType.allValues.count]
    }
    if nextMonster == .Zap && castleComponent.coins >= costZap {
      entityManager.spawnZap(teamComponent.team)
      nextMonster = MonsterType.allValues[Int(arc4random()) % MonsterType.allValues.count]
    }
    if nextMonster == .Munch && castleComponent.coins >= costMunch {
      entityManager.spawnMunch(teamComponent.team)
      nextMonster = MonsterType.allValues[Int(arc4random()) % MonsterType.allValues.count]
    }
  
  }

}