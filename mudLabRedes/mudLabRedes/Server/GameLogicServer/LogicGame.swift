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
    
    var modelPlayer : playerModel = playerModel()
    var modelPlayerList : playersList = playersList()
    
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
        print("game server")
        createPlayer(player: player1)
        createPlayer(player: player2)
        
        createGround()
        createMisturador()
        createEmptyNode()
        
        
        
    }
    
    public func movePlayer(points : CGPoint, name: String){
        
        if name == "player1" {
            player1.position = points
            
            for var p in modelPlayerList.players! {
                if  (p.id == "player1") {
                    
                    p.id = "player1"
                    p.position = points
                    
                }
            }
            
            
            
        }else if name == "player2"{
            player2.position = points
            
            for var p in modelPlayerList.players! {
                if  (p.id == "player2") {
                    p.id = "player2"
                    p.position = points
                    
                }
            }
        }
        
        
        
        
    }
    
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let location = touches.first?.location(in: self){
            
        }}
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
    }
    
    func instance () -> playersList{
        return modelPlayerList
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
        misturador.position = CGPoint(x: -37, y: 200)
        misturador.size = CGSize(width: 130, height: 130)
        misturador.name = "misturador"
        addChild(misturador)
    }
    
    @discardableResult
    func createPlayer(player: SKSpriteNode) -> SKSpriteNode{
        if modelPlayerList.countPlayer == 0 {
            player.name = "player1"
            player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            player.position = CGPoint(x: 0, y: 0)
            player.size = CGSize(width: 65, height: 65)
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (player.size.width), height: (player.size.height)), center: .zero)
            player.physicsBody?.affectedByGravity = false
            player.physicsBody?.isDynamic = true
            player.physicsBody?.categoryBitMask = 0b1
            player.physicsBody?.contactTestBitMask =  0b10
            //player.physicsBody?.collisionBitMask = 0b10000
            player.physicsBody?.allowsRotation = false
            player.zPosition = 3
            
            modelPlayer.key = false
            modelPlayer.cores = 0
            modelPlayer.stateDungeon = 0
            modelPlayer.position = player1.position
            modelPlayerList.players?.append(modelPlayer)
            modelPlayerList.countPlayer += 1
            
            
            scene?.addChild(player)
            
            
            
            
            return player
        }else{
            player2.name = "player2"
            player2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            player2.position = CGPoint(x: 0, y: 0)
            player2.size = CGSize(width: 65, height: 65)
            player2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (player2.size.width), height: (player2.size.height)), center: .zero)
            player2.physicsBody?.affectedByGravity = false
            player2.physicsBody?.isDynamic = true
            player2.physicsBody?.categoryBitMask = 0b1
            player2.physicsBody?.contactTestBitMask =  0b10
            //player.physicsBody?.collisionBitMask = 0b10000
            player2.physicsBody?.allowsRotation = false
            player2.zPosition = 3
            
            
            modelPlayer.key = false
            modelPlayer.cores = 0
            modelPlayer.stateDungeon = 0
            modelPlayer.position = player2.position
            modelPlayerList.players?.append(modelPlayer)
            modelPlayerList.countPlayer += 1
            scene?.addChild(player2)
            
            return player2
        }
        
        
        
        
        
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
