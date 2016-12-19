//
//  Bird.swift
//  FlappyBirdClone
//
//  Created by Alex DeMars on 12/16/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import SpriteKit

struct CollisionType {
  static let bird: UInt32 = 1
  static let ground: UInt32 = 2
  static let pipes: UInt32 = 3
  static let score: UInt32 = 4
}

class Bird: SKSpriteNode {
  
  func initialize() {
    // TODO: Create Animations
    self.name = "Bird"
    self.zPosition = 3
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 2)
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.allowsRotation = false
    self.physicsBody?.categoryBitMask = CollisionType.bird
    self.physicsBody?.collisionBitMask = CollisionType.ground | CollisionType.pipes
    self.physicsBody?.contactTestBitMask = CollisionType.ground | CollisionType.pipes | CollisionType.score
  }
  
  func flap() {
    self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
  }
  
}
