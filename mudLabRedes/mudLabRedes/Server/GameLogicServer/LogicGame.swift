//
//  playerControl.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import GameplayKit

class LogicGame: SKScene {

    var server: UDPServer?
    var players: GameScene?
    
    
    var ground = SKSpriteNode(imageNamed: "bg")
    var misturador = SKSpriteNode(imageNamed: "misturador")
    
    override func didMove(to view: SKView) {

        print("game server")
        server = UDPServer()
        createGround()
        createMisturador()
        
    }
    func createGround(){
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.position = CGPoint(x: 0, y: 0)
        ground.size = CGSize(width: (scene?.size.width)!, height: (scene?.size.height)!)
        ground.name = "ground"
        addChild(ground)
    }
    
    func createMisturador(){
           misturador.anchorPoint = CGPoint(x: 0.5, y: 0.5)
           misturador.position = CGPoint(x: -37, y: 217)
           misturador.size = CGSize(width: 130, height: 130)
           misturador.name = "misturador"
           addChild(misturador)
       }
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
          
          if let location = touches.first?.location(in: self){
                  print(location)
                }
      }
    override func update(_ currentTime: TimeInterval) {
   
    }
    
  

    
    
}
