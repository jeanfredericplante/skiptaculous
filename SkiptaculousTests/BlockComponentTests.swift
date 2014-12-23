//
//  BlockComponentTests.swift
//  Skiptaculous
//
//  Created by Jean Frederic Plante on 12/2/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import UIKit
import XCTest
import SpriteKit

class BlockComponentTests: XCTestCase {
    
    let scene = SKScene(size: CGSize(width: 130, height: 300))
    var bc = BlockComponent(currentPosition: 0, node: SKSpriteNode(imageNamed:"block1"))

    override func setUp() {
       super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewIsLoading() {
        // This is an example of a functional test case.

    }
    
    func testGetBlockPosition() {
        bc.blockNode.position = CGPointMake(0,0)
        XCTAssertTrue(bc.getBlockPosition() == 0, "get block position should be 0")
    }
    
    func testSetBlockPosition() {
        bc.setBlockPosition(10)
        XCTAssertTrue(bc.getBlockPosition() == 10, "set block position should have set the  block to 10")
    }
    
    func testBlockIsNotInView() {
        bc.blockNode.position = CGPointMake(CGRectGetMaxX(scene.frame)+bc.blockNode.size.width,0)
        XCTAssertFalse(bc.isWithinFrame(scene), "block should not be in view")
    }
    
    func testBlockIsInView() {
        bc.blockNode.position = CGPointMake(CGRectGetMaxX(scene.frame)-1,0)
        XCTAssertTrue(bc.isWithinFrame(scene), "block should be in view")
        
        bc.blockNode.position = CGPointMake(1,0)
        XCTAssertTrue(bc.isWithinFrame(scene), "block should be in view")

    }
    
    func testBlockNeedsToBeReset() {
        bc.blockNode.position = CGPointMake(-bc.blockNode.size.width-1,0)
        XCTAssertTrue(bc.shouldBeReset(scene), "block position should be reset")
        
        bc.blockNode.position = CGPointMake(CGRectGetMaxX(scene.frame)-1,0)
        XCTAssertTrue(bc.isWithinFrame(scene), "block should be in view")
        XCTAssertFalse(bc.shouldBeReset(scene), "block position should not be reset")

    }
    
    func testBlockIsShifted() {
        bc.blockNode.position = CGPointMake(1,0)
        XCTAssertTrue(bc.isWithinFrame(scene), "block should be in view")
        bc.moveBlockBy(CGRectGetMaxX(scene.frame)+bc.blockNode.size.width)
        XCTAssertFalse(bc.isWithinFrame(scene), "block should not be in view after being shifted")
    
    }
    
    func testBlockIsReset(){
        bc.resetPosition(scene, range: 200);
        XCTAssertFalse(bc.isWithinFrame(scene), "block should not be in view after being reset")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}