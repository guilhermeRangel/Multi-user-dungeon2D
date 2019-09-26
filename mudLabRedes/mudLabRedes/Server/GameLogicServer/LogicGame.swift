//
//  playerControl.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import GameplayKit

class LogicGame: SKScene, SKPhysicsContactDelegate {
    
    var modelPlayer : PlayerModel = PlayerModel()
    var modelPlayerList : PlayersList = PlayersList()
    
    var player1 = SKSpriteNode(imageNamed: "p1")
    var player2 = SKSpriteNode(imageNamed: "p2")
    
    var ground = SKSpriteNode(imageNamed: "bg")
    var misturador = SKSpriteNode(imageNamed: "misturador")
    
    var dorEsq = SKNode()
    var dorDir = SKNode()
    var dorBaixo = SKNode()
    var dorCima = SKNode()
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
     
        
        
        
    }
    
    public func movePlayer(points : CGPoint, name: String){
        
        if name == "player1" {
            player1.position = points
            
            for var p in modelPlayerList.players! {

                    p.position = points
                
            }
            
            
            
        }else if name == "player2"{
            player2.position = points
            
            for var p in modelPlayerList.players! {
               
                    p.position = points
                    
                
            }
        }
        
        
        
        
    }
    
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let location = touches.first?.location(in: self){
            
        }}
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
    }
 
    
    
    
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else { return}
        
        
        if((nodeA.name == "player1" && nodeB.name == "dorEsq") ||
            (nodeA.name == "dorEsq" && nodeB.name == "player1")){
            print("porta Esquerda")
            
            
        }
        
        if((nodeA.name == "player1" && nodeB.name == "dorDir") ||
            (nodeA.name == "dorDir" && nodeB.name == "player1")){
            
            print("porta Direita")
            
        }
        
        
        if((nodeA.name == "player" && nodeB.name == "dorBaixo") ||
            (nodeA.name == "dorBaixo" && nodeB.name == "player1")){
            print("porta Baixo")
            
            
        }
        
        if((nodeA.name == "player1" && nodeB.name == "dorCima") ||
            (nodeA.name == "dorCima" && nodeB.name == "player1")){
            print("porta Cima")
            
            
            if((nodeA.name == "player1" && nodeB.name == "misturador") ||
                (nodeA.name == "misturador" && nodeB.name == "player1")){
                
                print("Misturador")
            }
            
            
            if((nodeA.name == "player1" && nodeB.name == "backDor") ||
                (nodeA.name == "backDor" && nodeB.name == "player1")){
                
                print("Encontou na porta de volta")
            }
            
            if((nodeA.name == "player1" && nodeB.name == "itemRed") ||
                (nodeA.name == "itemRed" && nodeB.name == "player1")){
                
                print("Encontou na porta de volta")
            }
            
            if((nodeA.name == "player1" && nodeB.name == "itemBlue") ||
                (nodeA.name == "itemBlue" && nodeB.name == "player1")){
                
                print("Encontou na porta de volta")
            }
            
            if((nodeA.name == "player1" && nodeB.name == "itemYellow") ||
                (nodeA.name == "itemYellow" && nodeB.name == "player1")){
                
                print("Encontou na porta de volta")
            }
            
            
            
            
            
        }
        
    }
    
    
    
}
