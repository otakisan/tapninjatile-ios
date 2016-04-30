//
//  TileScene.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
//

import UIKit
import SpriteKit

class TileScene: SKScene {
    
    var launchTime = 0.0
    var gamePlayer : GamePlayer?
    var gameLimitTime = 10.0
    var isAppear = false
    var isStarted = false

    override func didMoveToView(view: SKView) {
        self.gamePlayer = GamePlayer()
        self.userInteractionEnabled = true
        
        self.updateScoreLabel()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !self.isStarted && isTapStartLabel(touches) {
            self.isStarted = true
            self.startLabelNode?.hidden = true
            return
        }
        
        let tileStates : [TileNodeState] = touches.flatMap {
            let location = $0.locationInNode(self)
            return (self.nodeAtPoint(location) as? TileNode)?.stateMachine.currentState as? TileNodeState
        }
                
        let sorted = tileStates.filter{$0.basePoint() > 0}.sort { $0.basePoint() < $1.basePoint() }
        for (index, tileState) in sorted.enumerate() {
            let basePoint = Double(tileState.basePoint())
            self.gamePlayer?.currentGameScore = (self.gamePlayer?.currentGameScore ?? 0) + Int((basePoint * pow(2.0, Double(index))))
            
            self.updateScoreLabel()
        }
        
        tileStates.forEach {$0.enterTappedState()}
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.isStarted {
            if self.launchTime == 0.0 || !self.isAppear {
                self.launchTime = currentTime
            }
            
            let remainingTime = self.gameLimitTime - (currentTime - self.launchTime)
            self.remainingTimeLabelNode?.text = "\(Int(ceil(remainingTime))) sec. remaining"
            
            if remainingTime > 0.0 {
                self.children.flatMap{$0 as? TileNode}.forEach{$0.stateMachine.updateWithDeltaTime(currentTime)}
            } else {
                let gameOverScene = GameOverScene(fileNamed: "GameOverScene")
                gameOverScene?.scaleMode = .AspectFit
                gameOverScene?.gamePlayer = self.gamePlayer
                self.view?.presentScene(gameOverScene)
            }
        }
    }
    
    private func isTapStartLabel(touches: Set<UITouch>) -> Bool {
        return touches.filter {
            let location = $0.locationInNode(self)
            return self.nodeAtPoint(location).name == "StartLabelNode"
        }.count > 0
    }
    
    private func updateScoreLabel() {
        self.scoreLabel?.text = "\(self.gamePlayer?.currentGameScore ?? 0) pt."
    }
    
    var scoreLabel : SKLabelNode? {
        get {
            return self.childNodeWithName("ScoreLabelNode") as? SKLabelNode
        }
    }
    
    var remainingTimeLabelNode : SKLabelNode? {
        get {
            return self.childNodeWithName("RemainingTimeLabelNode") as? SKLabelNode
        }
    }
    
    var startLabelNode : SKLabelNode? {
        get {
            return self.childNodeWithName("StartLabelNode") as? SKLabelNode
        }
    }
}
