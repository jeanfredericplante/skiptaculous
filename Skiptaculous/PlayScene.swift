//
//  PlayScene.swift
//  Based on Skip Wilson Youtube tutorials
//
//  Created by Jean Frederic Plante on 11/29/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    let runningBar = SKSpriteNode(imageNamed:"ground")
    let hero = SKSpriteNode(imageNamed:"hero")
    let block1 = SKSpriteNode(imageNamed:"block1")
    let block2 = SKSpriteNode(imageNamed:"block2")
    let heroScale = CGFloat(0.15)
    let scoreText = SKLabelNode(fontNamed: "Chalkduster")
    
    var origRunningBarPosition = CGFloat(0)
    var repeatPixels = CGFloat(286)
    var resetBlockRange = UInt32(400)
    var groundSpeed = CGFloat(5)
    var heroBaseline = CGFloat(0)
    var xFramePos =  CGFloat(0)
    var onGround = true
    var heroHitABlock = false
    var velocityY = CGFloat(0)
    var horizontalBarSliding = CGFloat(0)
    var fakeGravity = CGFloat(0.6)
    var sceneBlocks:Dictionary<String, BlockComponent> = [:]
    var score = 0
    
    enum ColliderType:UInt32   {
        case Hero = 1
        case Block = 2
        case Ground = 3
    }
    
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor()
        self.xFramePos = CGRectGetMinX(self.frame)
        
        // position running bar
        self.runningBar.anchorPoint =  CGPointMake(0,0);
        self.runningBar.position = CGPointMake(
            self.xFramePos,
            CGRectGetMinY(self.frame) - 0.7*self.runningBar.size.height)
        
        self.origRunningBarPosition = self.runningBar.position.x
        self.repeatPixels *= -1
        
        
        // scale objects
        scaleObject(self.hero, scale: heroScale)
        scaleObject(self.block1, scale: heroScale)
        scaleObject(self.block2, scale: heroScale)

        
        // position hero
        self.heroBaseline = CGRectGetMaxY(self.runningBar.frame)
        self.hero.position = CGPointMake(self.xFramePos + self.hero.size.width/2,
            self.heroBaseline + self.hero.size.height/2)
        
        
        // position blocks and adds them to the dictionary
        self.block1.name = "block1"
        self.block1.position = CGPointMake(
            CGRectGetMaxX(self.frame)+self.block1.size.width,
            getGroundPositionY(block1))
        
        self.block2.name = "block2"
        self.block2.position = CGPointMake(
            CGRectGetMaxX(self.frame)+self.block2.size.width,
            getGroundPositionY(block2))
        
        sceneBlocks["block1"] = BlockComponent(node: self.block1)
        sceneBlocks["block1"]?.resetPosition(self, range: resetBlockRange)
        sceneBlocks["block2"] = BlockComponent(node: self.block2)
        sceneBlocks["block2"]?.resetPosition(self, range: resetBlockRange)

        // sets the collision detection
        self.physicsWorld.contactDelegate = self
        setCollisionDetection()
        
        
        // adds the score
        self.scoreText.text = String(score)
        self.scoreText.fontSize = 42
        self.scoreText.fontColor = UIColor.grayColor()
        self.scoreText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-2*self.scoreText.frame.height)
        
        // add nodes for display
        self.addChild(self.scoreText)
        self.addChild(self.runningBar)
        self.addChild(self.hero)
        self.addChild(self.block1)
        self.addChild(self.block2)
       
        
    }
    
    func  didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == ColliderType.Block.rawValue) ||
        (contact.bodyA.categoryBitMask == ColliderType.Block.rawValue)
        {
            heroHitABlock = true
           // self.scoreText.text = "hit a block"
            
        } else if (contact.bodyA.categoryBitMask == ColliderType.Ground.rawValue) ||
        (contact.bodyA.categoryBitMask == ColliderType.Ground.rawValue)
        {
            if !onGround
            {
                onGround = true // hero now touches the ground
                if !heroHitABlock
                {
                    // hero jumped and touched the ground without hitting a block
                    score += 5
                    self.scoreText.text = String(score)
                }
                
                heroHitABlock = false // reset the hit count
               // self.scoreText.text = "on ground"
            }
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == ColliderType.Ground.rawValue) ||
        (contact.bodyB.categoryBitMask == ColliderType.Ground.rawValue)
        {
            onGround = false
            //self.scoreText.text = "off ground"
        }
    }
    
    func restart() {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
        {
            let skView = self.view as SKView!
            skView.ignoresSiblingOrder = true
            scene.size = skView.bounds.size
            scene.scaleMode = SKSceneScaleMode.AspectFill
            skView.presentScene(scene)
            
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

            if (onGround) {
                var impulseX = CGFloat(5)
                var impulseY = CGFloat(100)
                self.hero.physicsBody?.applyImpulse(CGVectorMake(impulseX, impulseY))
            }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        // shifts the ground
        horizontalBarSliding += CGFloat(self.groundSpeed)
        horizontalBarSliding = horizontalBarSliding%repeatPixels
        runningBar.position.x = self.origRunningBarPosition - horizontalBarSliding
        
        
        // rotate the ball according to ground velocity
        self.hero.zRotation -= 2*self.groundSpeed/(self.hero.size.height)
        
        blockRunner(CGFloat(self.groundSpeed))
    }
    
    // Private methods
    func objectTouchesGround(myblob: SKSpriteNode) -> Bool {
        if (myblob.position.y - myblob.size.height/2) < self.heroBaseline {
            return true
        } else {
            return false
        }
    }
    
    func blockRunner(pixelsToSlide: CGFloat) {
        for(block,blockComponent) in self.sceneBlocks
        {

            if blockComponent.shouldBeReset(self)
            {
                blockComponent.resetPosition(self, range: resetBlockRange)
            } else  // Should be shifted
            {
                blockComponent.moveBlockBy(-pixelsToSlide)
            }
            
        }
    }
    
    func getGroundPositionY(myblob: SKSpriteNode) -> CGFloat {
        return self.heroBaseline + myblob.size.height/2
    }
    
    func scaleObject(myblob: SKSpriteNode, scale: CGFloat) -> Void {
        myblob.xScale = scale
        myblob.yScale = myblob.xScale
    }
    
    func positionBlocRandomely() -> CGFloat {
        var posRange = UInt32(50)...UInt32(200)
        return CGFloat(posRange.startIndex + arc4random_uniform(posRange.endIndex-posRange.startIndex + 1))
    }
    
    func setCollisionDetection() {
        // for the hero
        self.hero.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.hero.size.width / 2))
        self.hero.physicsBody?.affectedByGravity = true
        self.hero.physicsBody?.categoryBitMask = ColliderType.Hero.rawValue
        self.hero.physicsBody?.collisionBitMask = ColliderType.Block.rawValue
        self.hero.physicsBody?.contactTestBitMask = ColliderType.Block.rawValue
        
        // for the ground
        var rectHeight = self.heroBaseline - CGRectGetMinY(self.frame)
        var rectWidth = self.runningBar.size.width
        var rectXMid = CGFloat(rectWidth/2)
        var rectYMid = CGFloat(rectHeight/2 - self.runningBar.position.y)
        self.runningBar.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: rectWidth, height: rectHeight), center: CGPointMake(rectXMid, rectYMid))
        self.runningBar.physicsBody?.dynamic = false
        self.runningBar.physicsBody?.categoryBitMask = ColliderType.Ground.rawValue
        
        // for the blocks
        for (blockName, blockComponent) in self.sceneBlocks
        {
            var blockNode = blockComponent.blockNode
            blockNode.physicsBody  = SKPhysicsBody(rectangleOfSize: blockNode.size)
            blockNode.physicsBody?.dynamic=false
            blockNode.physicsBody?.categoryBitMask = ColliderType.Block.rawValue
            blockNode.physicsBody?.contactTestBitMask = ColliderType.Hero.rawValue
            blockNode.physicsBody?.collisionBitMask = ColliderType.Hero.rawValue
        }

    }
    
}
