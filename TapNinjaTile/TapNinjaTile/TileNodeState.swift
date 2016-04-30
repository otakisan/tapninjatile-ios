//
//  TileNodeState.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
//

import UIKit
import GameplayKit

class TileNodeState: GKState {
    
    let randomDistribution = GKRandomDistribution(lowestValue: 1, highestValue: 100)
    weak var tileNode : TileNode?
    var prevEnteredDatetime = NSDate()
    
    init(tileNode : TileNode?) {
        self.tileNode = tileNode
    }
    
    func basePoint() -> Int {
        return 0
    }
    
    func backgroundColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    func enterNextState() {
        let randomNumber = randomDistribution.nextInt()
        if randomNumber % 50 == 0 {
            self.tileNode?.stateMachine.enterState(BonusTileState)
        } else if randomNumber % 4 == 0 {
            self.tileNode?.stateMachine.enterState(NormalTileState)
        } else {
            self.tileNode?.stateMachine.enterState(HiddenTileState)
        }
    }
    
    func enterTappedState() {
        self.tileNode?.stateMachine.enterState(TappedTileState)
    }
    
    func isRefreshPrevEnteredDatetime() -> Bool {
        return true
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        if NSDate().timeIntervalSinceDate(self.prevEnteredDatetime) > 0.8 {
            self.enterNextState()
        }
        
        self.tileNode?.color = self.backgroundColor()
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {        
        if self.isRefreshPrevEnteredDatetime() {
            self.prevEnteredDatetime = NSDate()
        }
        
        //self.tileNode?.color = self.backgroundColor()
    }
}

class HiddenTileState : TileNodeState {
    override func enterTappedState() {
    }
}

class NormalTileState : TileNodeState {
    override func basePoint() -> Int {
        return 1
    }
    
    override func backgroundColor() -> UIColor {
        return UIColor.blueColor()
    }
}

class BonusTileState : TileNodeState {
    override func basePoint() -> Int {
        return 10
    }
    
    override func backgroundColor() -> UIColor {
        return UIColor(colorLiteralRed: 255.0 / 255.0, green: 223.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
}

class TappedTileState : TileNodeState {
    override func backgroundColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    override func isRefreshPrevEnteredDatetime() -> Bool {
        return false
    }
}
