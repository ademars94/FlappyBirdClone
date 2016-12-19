//
//  GameplayScene.swift
//  FlappyBirdClone
//
//  Created by Alex DeMars on 12/16/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
  
  var bird = Bird()
  var pipeHolder = SKNode()
  var scoreLabel = SKLabelNode(fontNamed: "04b_19")
  var score = 0

  override func didMove(to view: SKView) {
    print("Initializing...")
    initialize()
  }
  
  func initialize() {
    physicsWorld.contactDelegate = self
    
    createBackground()
    createGround()
    createBird()
    spawnObstacles()
    createLabel()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    bird.flap()
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    
    if contact.bodyA.node?.name == "Bird" {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    } else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }
    
    if firstBody.node?.name == "Bird" && secondBody.node?.name == "Score" {
      incrementScore()
    }
    
  }
  
  override func update(_ currentTime: TimeInterval) {
    moveBackground()
    moveGround()
  }
  
  func createBird() {
    bird = Bird(imageNamed: "Blue 1")
    bird.initialize()
    bird.position = CGPoint(x: -50, y: 0)
    self.addChild(bird)
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
  
  func createPipes() {
    pipeHolder = SKNode()
    pipeHolder.name = "Holder"
    let pipeUp = SKSpriteNode(imageNamed: "Pipe 1")
    let pipeDown = SKSpriteNode(imageNamed: "Pipe 1")
    let destination = self.frame.width * 2
    
    let scoreNode = SKSpriteNode()
    scoreNode.name = "Score"
    scoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    scoreNode.position = CGPoint(x: 0, y: 0)
    scoreNode.size = CGSize(width: 5, height: 300)
    scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
    scoreNode.physicsBody?.categoryBitMask = CollisionType.score
    scoreNode.physicsBody?.collisionBitMask = 0; // Make sure this node doesn't collide with bird
    scoreNode.physicsBody?.affectedByGravity = false
    scoreNode.physicsBody?.isDynamic = false
    
    pipeUp.name = "Pipe"
    pipeUp.position = CGPoint(x: 0, y: 630)
    pipeUp.zRotation = CGFloat(M_PI)
    pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    pipeUp .yScale = 1.5
    pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
    pipeUp.physicsBody?.affectedByGravity = false
    pipeUp.physicsBody?.isDynamic = false
    pipeUp.physicsBody?.categoryBitMask = CollisionType.pipes
    
    pipeDown.name = "Pipe"
    pipeDown.position = CGPoint(x: 0, y: -630)
    pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    pipeDown.yScale = 1.5
    pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size)
    pipeDown.physicsBody?.affectedByGravity = false
    pipeDown.physicsBody?.isDynamic = false
    pipeDown.physicsBody?.categoryBitMask = CollisionType.pipes
    
    pipeHolder.addChild(pipeUp)
    pipeHolder.addChild(pipeDown)
    pipeHolder.addChild(scoreNode)
    
    pipeHolder.position.x = self.frame.width + 100
    pipeHolder.position.y = CGFloat.randomBetween(first: -300, second: 300)
    pipeHolder.zPosition = 5
    
    self.addChild(pipeHolder)
    
    let move = SKAction.moveTo(x: -destination, duration: TimeInterval(10))
    let remove = SKAction.removeFromParent()
    
    pipeHolder.run(SKAction.sequence([move, remove]), withKey: "Move")
  }
  
  func createLabel() {
    scoreLabel.zPosition = 6
    scoreLabel.position = CGPoint(x: 0, y: 450)
    scoreLabel.fontSize = 120
    scoreLabel.text = "0"
    self.addChild(scoreLabel)
  }
  
  func incrementScore() {
    score += 1
    scoreLabel.text = String(describing: score)
  }
  
  func moveBackground() {
    enumerateChildNodes(withName: "BG", using: { node, error in
      node.position.x -= 2
      if node.position.x < -(self.frame.width) {
        node.position.x += self.frame.width * 3
      }
    })
  }
  
  func moveGround() {
    enumerateChildNodes(withName: "Ground", using: { node, error in
      node.position.x -= 4
      if node.position.x < -(self.frame.width) {
        node.position.x += self.frame.width * 3
      }
    })
  }
  
  func spawnObstacles() {
    let spawn = SKAction.run({ () -> Void in
      self.createPipes()
    })
    
    let delay = SKAction.wait(forDuration: 2)
    
    let sequence = SKAction.sequence([spawn, delay])
    
    self.run(SKAction.repeatForever(sequence), withKey: "Spawn")
  }
  
}
