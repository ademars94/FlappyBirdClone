//
//  GameplayScene.swift
//  FlappyBirdClone
//
//  Created by Alex DeMars on 12/16/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
  
  var bird = Bird()

  override func didMove(to view: SKView) {
    print("Initializing...")
    initialize()
  }
  
  func initialize() {
    createBackground()
    createGround()
    createBird()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    bird.flap()
  }
  
  func createBird() {
    bird = Bird(imageNamed: "Blue 1")
    bird.initialize()
    bird.position = CGPoint(x: -50, y: 0)
    self.addChild(bird)
  }
  
  override func update(_ currentTime: TimeInterval) {
    moveBackground()
    moveGround()
  }
  
  func createBackground() {
    for i in 0...2 {
      let background = SKSpriteNode(imageNamed: "BG Day")
      background.name = "BG"
      background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      background.position = CGPoint(x: CGFloat(i) * background.size.width , y: 0)
      self.addChild(background)
    }
  }
  
  func createGround() {
    for i in 0...2 {
      let ground = SKSpriteNode(imageNamed: "Ground")
      ground.name = "Ground"
      ground.zPosition = 4
      ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 2))
      ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
      ground.physicsBody?.affectedByGravity = false
      ground.physicsBody?.isDynamic = false
      ground.physicsBody?.categoryBitMask = CollisionType.ground
      ground.physicsBody?.collisionBitMask = CollisionType.bird
      ground.physicsBody?.contactTestBitMask = CollisionType.bird
      self.addChild(ground)
    }
  }
  
  func moveBackground() {
    enumerateChildNodes(withName: "BG", using: { node, error in
      node.position.x -= 1
      if node.position.x < -(self.frame.width) {
        node.position.x += self.frame.width * 3
      }
    })
  }
  
  func moveGround() {
    enumerateChildNodes(withName: "Ground", using: { node, error in
      node.position.x -= 3
      if node.position.x < -(self.frame.width) {
        node.position.x += self.frame.width * 3
      }
    })
  }
  
}
