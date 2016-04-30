//
//  TileNode.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TileNode: SKSpriteNode {

    lazy var stateMachine : GKStateMachine = {
        let stateMachine = GKStateMachine(states: [
            HiddenTileState(tileNode: self),
            NormalTileState(tileNode: self),
            BonusTileState(tileNode: self),
            TappedTileState(tileNode: self)
            ])
        
        stateMachine.enterState(HiddenTileState)
        return stateMachine
    }()
}
