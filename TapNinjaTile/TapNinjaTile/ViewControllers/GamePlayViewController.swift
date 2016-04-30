//
//  GamePlayViewController.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlayViewController: UIViewController {
    
    var scene : TileScene?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initAnalysisTracker("ゲームプレイ")
        
        self.scene?.isAppear = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func initialize() {
        if let scene = TileScene(fileNamed:"TileScene") {
            self.scene = scene
            
            // Configure the view.
            let skView = self.view as! SKView
            //skView.showsFPS = true
            //skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
        }
    }
}
