//
//  GameOverScene.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    var gamePlayer : GamePlayer?
    
    var scoreLabel : SKLabelNode? {
        get {
            return self.childNodeWithName("ScoreLabelNode") as? SKLabelNode
        }
    }
    
    var gradeLabel : SKLabelNode? {
        get {
            return self.childNodeWithName("GradeLabelNode") as? SKLabelNode
        }
    }
    
    override func didMoveToView(view: SKView) {
        self.initialize()
    }
    
    private func initialize() {
        self.scoreLabel?.text = "\("Score".localized()) : \(self.gamePlayer?.currentGameScore ?? 0)"
        self.gradeLabel?.text = self.gradeText()
    }
    
    private func gradeText() -> String {
        var gradeText = "eval_try_again".localized()
        
        if self.gamePlayer?.currentGameScore >= 80 {
            gradeText = "eval_incredible".localized()
        } else if self.gamePlayer?.currentGameScore >= 50 {
            gradeText = "eval_amazing".localized()
        } else if self.gamePlayer?.currentGameScore >= 30 {
            gradeText = "eval_great".localized()
        } else if self.gamePlayer?.currentGameScore >= 10 {
            gradeText = "eval_nice".localized()
        }
        
        return gradeText
    }
}
