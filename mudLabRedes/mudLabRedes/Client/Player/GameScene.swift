//
//  playerControl.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var client : UDPClient?
    
    override func didMove(to view: SKView) {
  
        client = UDPClient()
        print("to na game")
        
    }
   
    
    

    override func update(_ currentTime: TimeInterval) {
   
    }
    
  
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            
            client?.sendInitialFrame()
            
        }
    
    }
    
    
}
