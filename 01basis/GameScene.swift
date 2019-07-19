//
//  GameScene.swift
//  01basis
//
//  Created by Nikolas Omelianov on 7/15/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var spaceShip: SKSpriteNode!
    override func didMove(to view: SKView) {
        setScreen()
        addSpaceShip()
        addAsteroids()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let moveAction = SKAction.move(to: touchLocation, duration: 1)
            spaceShip.run(moveAction)
        }
    }
    func createAsteroid() -> SKSpriteNode {
        let asteroidKind = "spaceMeteors_00" + String(arc4random() % 4 + 1)
        let asteroid = SKSpriteNode(imageNamed: asteroidKind)
        asteroid.setScale(0.15)
        asteroid.position.x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 16))
        asteroid.position.y = frame.size.height + asteroid.size.height
        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        return asteroid
    }
    func addAsteroids(){
        let asteroidCreate = SKAction.run {
            let asteroid = self.createAsteroid()
            self.addChild(asteroid)
        }
        let asteroidCreationInterval = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        let asteroidSequenceAction = SKAction.sequence([asteroidCreate,asteroidCreationInterval])
        let asteroidRunAction = SKAction.repeatForever(asteroidSequenceAction)
        run(asteroidRunAction)
    }
    func setScreen(){
        let spaceBG = SKSpriteNode(imageNamed: "backgroundsp")
        spaceBG.size = CGSize(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height * 3)
        addChild(spaceBG)
    }
    func addSpaceShip(){
        let spaceShipKind = "spaceShips_00" + String(arc4random() % 9 + 1)
        spaceShip = SKSpriteNode(imageNamed: spaceShipKind)
        spaceShip.setScale(0.4)
        spaceShip.position = CGPoint(x: 0, y: 0)
        spaceShip.physicsBody = SKPhysicsBody(texture: spaceShip.texture!, size: spaceShip.size)
        spaceShip.physicsBody?.isDynamic = false
        addChild(spaceShip)
    }
    override func update(_ currentTime: TimeInterval) {
    }
}
