//
//  GameViewController.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
class GameViewController2: UIViewController {
    
    @IBOutlet weak var skview: SKView!
    
    
    
    var scene: GameScene2?
    
    fileprivate func createScene() {
        scene = GameScene2(size: view.bounds.size)
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.showsPhysics = true
        scene?.scaleMode = .aspectFill
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene?.physicsBody = SKPhysicsBody.init(edgeLoopFrom: scene!.frame)
        skview.presentScene(scene!)
    }
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entrei")
        createScene()
       
    }


}

