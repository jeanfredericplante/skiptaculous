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
    var position = UInt32(0)
    
    init(isRunning: Bool, position: UInt32) {
        self.isRunning = isRunning
        self.position = position
    }
    
    func moveBlockBy(delta: UInt32) -> Void {
        self.position += delta
    }
    
    func isWithinFrame(scene: SKScene, blob: SKSpriteNode) -> Bool {
        var blobMaxX = CGRectGetMaxX(blob.frame)
        var blobMinX = CGRectGetMinX(blob.frame)
        var atLeastRightSideInView =  (blobMaxX > CGRectGetMinX(scene.frame)) && (blobMaxX <  CGRectGetMaxX(scene.frame))
        var atLeastLeftSideInView =  (blobMinX > CGRectGetMinX(scene.frame)) && (blobMinX <  CGRectGetMaxX(scene.frame))
        return atLeastRightSideInView || atLeastLeftSideInView
    }
    
}