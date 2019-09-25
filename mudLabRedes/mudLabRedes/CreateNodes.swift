//
//  creates.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 25/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import SpriteKit
class CreateNodes {
    
    func createGround(scene : Any ,nodo : SKSpriteNode){
        nodo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nodo.position = CGPoint(x: 0, y: 0)
        nodo.name = "ground"
        
        if let cena = scene as? GameScene {
            nodo.size = CGSize(width: (cena.size.width), height: (cena.size.height))
            cena.addChild(nodo)
        }else if let cena = scene as? GameScene2 {
            nodo.size = CGSize(width: (cena.size.width), height: (cena.size.height))
            cena.addChild(nodo)
        }else if let cena = scene as? LogicGame {
            nodo.size = CGSize(width: (cena.size.width), height: (cena.size.height))
            cena.addChild(nodo)
        }
    }
    
    
    func createPlayer(scene : Any, nodo : SKSpriteNode){
        nodo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nodo.position = CGPoint(x: 0, y: 0)
        nodo.size = CGSize(width: 65, height: 65)
        nodo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (nodo.size.width), height: (nodo.size.height)), center: .zero)
        nodo.physicsBody?.affectedByGravity = false
        nodo.physicsBody?.isDynamic = true
        nodo.physicsBody?.categoryBitMask = 0b1
        nodo.physicsBody?.contactTestBitMask =  0b10
        //player.physicsBody?.collisionBitMask = 0b10000
        nodo.physicsBody?.allowsRotation = false
        nodo.zPosition = 3
        
        if let cena = scene as? GameScene {
            nodo.name = "player1"
            cena.addChild(nodo)
        }else if let cena = scene as? GameScene2 {
            nodo.name = "player2"
            print("entrei aqui")
            cena.addChild(nodo)
        }else if let cena = scene as? LogicGame {
            nodo.name = "player1"
            cena.addChild(nodo)
        }
    }
    
    func createPlayer2(scene : Any, nodo : SKSpriteNode){
        nodo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nodo.position = CGPoint(x: 0, y: 0)
        nodo.size = CGSize(width: 65, height: 65)
        
        nodo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (nodo.size.width), height: (nodo.size.height)), center: .zero)
        nodo.physicsBody?.affectedByGravity = false
        nodo.physicsBody?.isDynamic = true
        nodo.physicsBody?.categoryBitMask = 0b1
        nodo.physicsBody?.contactTestBitMask =  0b10
        //player.physicsBody?.collisionBitMask = 0b10000
        nodo.physicsBody?.allowsRotation = false
        nodo.zPosition = 3
        
        if let cena = scene as? GameScene {
            nodo.name = "player2"
            cena.addChild(nodo)
        }else if let cena = scene as? GameScene2 {
            nodo.name = "player1"
            cena.addChild(nodo)
        }else if let cena = scene as? LogicGame {
            nodo.name = "player2"
            cena.addChild(nodo)
        }
        
    }
    func createEmptyNode(scene : Any, dorEsq : SKNode, dorDir : SKNode, dorBaixo : SKNode, dorCima : SKNode){
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
        if let cena = scene as? GameScene {
            cena.addChild(dorEsq)
            cena.addChild(dorDir)
            cena.addChild(dorBaixo)
            cena.addChild(dorCima)
        }else if let cena = scene as? GameScene2{
            cena.addChild(dorEsq)
            cena.addChild(dorDir)
            cena.addChild(dorBaixo)
            cena.addChild(dorCima)
        }
        else if let cena = scene as? LogicGame{
            cena.addChild(dorEsq)
            cena.addChild(dorDir)
            cena.addChild(dorBaixo)
            cena.addChild(dorCima)
        }
        
    }
    
    
    
    func createMisturador(scene : Any, nodo : SKSpriteNode){
        nodo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nodo.size = CGSize(width: 130, height: 130)
        nodo.name = "misturador"
        nodo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        nodo.position = CGPoint(x: -3, y: 174  )
        nodo.physicsBody?.categoryBitMask = 0b10
        nodo.physicsBody?.contactTestBitMask = 0b1
        nodo.physicsBody?.collisionBitMask = 0
        nodo.physicsBody?.isDynamic = false
        nodo.physicsBody?.allowsRotation = false
        nodo.physicsBody?.affectedByGravity = false
        
        if let cena = scene as? GameScene {
            cena.addChild(nodo)
        }else if let cena = scene as? GameScene2 {
            cena.addChild(nodo)
        }else if let cena = scene as? LogicGame {
            cena.addChild(nodo)
        }
        
    }
    
    func initAllNodes(scene : Any, player : SKSpriteNode, ground : SKSpriteNode,
                      misturador : SKSpriteNode, dorEsq : SKNode, dorDir : SKNode, dorBaixo : SKNode, dorCima : SKNode){
        
        createPlayer(scene: scene, nodo: player)
        createGround(scene: scene, nodo: ground)
        createEmptyNode(scene: scene, dorEsq: dorEsq, dorDir: dorDir, dorBaixo: dorBaixo, dorCima: dorCima)
        createMisturador(scene: scene, nodo: misturador)
        
    }
}

