//
//  SoundManager.swift
//  MonsterWars
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit

class SoundManager {

  let soundPew = SKAction.playSoundFileNamed("pew.wav", waitForCompletion: false)
  let soundPew2 = SKAction.playSoundFileNamed("pew2.wav", waitForCompletion: false)
  let soundBoom = SKAction.playSoundFileNamed("boom.wav", waitForCompletion: false)
  let soundSpawn = SKAction.playSoundFileNamed("spawn.wav", waitForCompletion: false)
  let soundAttack = SKAction.playSoundFileNamed("attack.wav", waitForCompletion: false)
  let soundDefend = SKAction.playSoundFileNamed("defend.wav", waitForCompletion: false)
  let soundBigHit = SKAction.playSoundFileNamed("bigHit.wav", waitForCompletion: false)
  let soundSmallHit = SKAction.playSoundFileNamed("smallHit.wav", waitForCompletion: false)
 
  static let sharedInstance = SoundManager()

}