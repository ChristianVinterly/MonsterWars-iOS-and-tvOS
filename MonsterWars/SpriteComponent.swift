//
//  SpriteComponent.swift
//  DinoDefense
//
//  Created by Toby Stephens on 20/10/2015.
//  Copyright © 2015 razeware. All rights reserved.
//

import SpriteKit
import GameplayKit

//class EntityNode: SKSpriteNode {
//  weak var entity: GKEntity!
//}

class SpriteComponent: GKComponent {
//  
//  // A node that gives an entity a visual sprite
//  let node: EntityNode
  let node: SKSpriteNode
  
  init(entity: GKEntity, texture: SKTexture, size: CGSize) {
    node = SKSpriteNode(texture: texture,
      color: SKColor.whiteColor(), size: size)
    //node.entity = entity
  }
  
}

