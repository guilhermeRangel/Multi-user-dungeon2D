//
//  playerControl.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
   // MARK
    //fazer o p1 enxergar o p2, acredito q o server deva enviar um ack de volta para poder fazer isso
    
    var player2 = SKSpriteNode(imageNamed: "p2")
    var move = false

    
    var player = SKSpriteNode(imageNamed: "p1")
    var server : UDPServer?
    var client : UDPClient?
   
    
    var ground = SKSpriteNode(imageNamed: "bg")
    var misturador = SKSpriteNode(imageNamed: "misturador")
    
    var dorEsq = SKNode()
    var dorDir = SKNode()
    var dorBaixo = SKNode()
    var dorCima = SKNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self

        
        createPlayer()
        createGround()
        createMisturador()
        createEmptyNode()
        
        client = UDPClient(scene: self, scene2: nil)
           client?.sendInitialFrame(position: player.position, node: player)
        
    }
    
    
    
    
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let location = touches.first?.location(in: self){
            player.position = location
            move = true
           
            
            
        }
    }
    
    
    
    
    
    func createPlayer(){
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: 0, y: 0)
        player.size = CGSize(width: 65, height: 65)
        player.name = "player1"
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (player.size.width), height: (player.size.height)), center: .zero)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = 0b1
        player.physicsBody?.contactTestBitMask =  0b10
        //player.physicsBody?.collisionBitMask = 0b10000
        player.physicsBody?.allowsRotation = false
        player.zPosition = 3
        addChild(player)
    }
    
    func createPlayer2(){
         player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
         player.position = CGPoint(x: 0, y: 0)
         player.size = CGSize(width: 65, height: 65)
         player.name = "player2"
         player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (player.size.width), height: (player.size.height)), center: .zero)
         player.physicsBody?.affectedByGravity = false
         player.physicsBody?.isDynamic = true
         player.physicsBody?.categoryBitMask = 0b1
         player.physicsBody?.contactTestBitMask =  0b10
         //player.physicsBody?.collisionBitMask = 0b10000
         player.physicsBody?.allowsRotation = false
         player.zPosition = 3
         addChild(player2)
     }
    
    func createEmptyNode(){
        dorEsq.name = "dorEsq"
        dorDir.name = "dorDir"
        dorBaixo.name = "dorBaixo"
        dorCima.name = "dorCima"
        
        dorDir.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        dorDir.position = CGPoint(x: 161, y: -5  )
        dorDir.physicsBody?.categoryBitMask = 0b10
        dorDir.physicsBody?.contactTestBitMask = 0b1
        dorDir.physicsBody?.collisionBitMask = 0
        dorDir.physicsBody?.isDynamic = false
        dorDir.physicsBody?.allowsRotation = false
        dorDir.physicsBody?.affectedByGravity = false
        
        dorEsq.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        dorEsq.position = CGPoint(x: -161, y: -5  )
        dorEsq.physicsBody?.categoryBitMask = 0b10
        dorEsq.physicsBody?.contactTestBitMask = 0b1
        dorEsq.physicsBody?.collisionBitMask = 0
        dorEsq.physicsBody?.isDynamic = false
        dorEsq.physicsBody?.allowsRotation = false
        dorEsq.physicsBody?.affectedByGravity = false
        
        dorBaixo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        dorBaixo.position = CGPoint(x: 0, y: -336  )
        dorBaixo.physicsBody?.categoryBitMask = 0b10
        dorBaixo.physicsBody?.contactTestBitMask = 0b1
        dorBaixo.physicsBody?.collisionBitMask = 0
        dorBaixo.physicsBody?.isDynamic = false
        dorBaixo.physicsBody?.allowsRotation = false
        dorBaixo.physicsBody?.affectedByGravity = false
        
        dorCima.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        dorCima.position = CGPoint(x: 0, y: 357  )
        dorCima.physicsBody?.categoryBitMask = 0b10
        dorCima.physicsBody?.contactTestBitMask = 0b1
        dorCima.physicsBody?.collisionBitMask = 0
        dorCima.physicsBody?.isDynamic = false
        dorCima.physicsBody?.allowsRotation = false
        dorCima.physicsBody?.affectedByGravity = false
        
        addChild(dorEsq)
        addChild(dorDir)
        addChild(dorBaixo)
        addChild(dorCima)
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
        misturador.size = CGSize(width: 130, height: 130)
        misturador.name = "misturador"
        misturador.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        misturador.position = CGPoint(x: -3, y: 174  )
        misturador.physicsBody?.categoryBitMask = 0b10
        misturador.physicsBody?.contactTestBitMask = 0b1
        misturador.physicsBody?.collisionBitMask = 0
        misturador.physicsBody?.isDynamic = false
        misturador.physicsBody?.allowsRotation = false
        misturador.physicsBody?.affectedByGravity = false
        
        addChild(misturador)
    }
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if move == true {
            move = false
            client?.sendFrame(node: player)
        }
         
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
        
        
        if((nodeA.name == "player1" && nodeB.name == "dorBaixo") ||
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
