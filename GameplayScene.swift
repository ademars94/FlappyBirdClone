//
//  GameplayScene.swift
//  FlappyBirdClone
//
//  Created by Alex DeMars on 12/16/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {

  override func didMove(to view: SKView) {
    print("Initializing...")
    initialize()
  }
  
  func initialize() {
    createBackground()
    createGround()
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
      self.addChild(ground)
    }
  }
  
}
