//
//  BlockComponent.swift
//  Skiptaculous
//
//  Created by Jean Frederic Plante on 12/1/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import Foundation
import SpriteKit

class BlockComponent {
    var isRunning = false
    var blockNode: SKSpriteNode
    
    init(isRunning: Bool, node: SKSpriteNode) {
        self.isRunning = isRunning
        self.blockNode = node
    }
    
    func moveBlockBy(delta: CGFloat) -> Void {
        self.blockNode.position.x += delta
    }
    
    func isWithinFrame(scene: SKScene) -> Bool {
        var blobMaxX = CGRectGetMaxX(self.blockNode.frame)
        var blobMinX = CGRectGetMinX(self.blockNode.frame)
        var sceneMinX = CGRectGetMinX(scene.frame)
        var sceneMaxX = CGRectGetMaxX(scene.frame)
        var leftSideRightofView: Bool =  (blobMinX > sceneMaxX)
        var rightSideLeftofView: Bool =  (blobMaxX < sceneMinX)
        return !(leftSideRightofView || rightSideLeftofView)
    }
    
}