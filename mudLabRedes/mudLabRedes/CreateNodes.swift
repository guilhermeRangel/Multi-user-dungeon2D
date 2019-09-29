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
    
    func createGroundEsq(scene : Any ,nodo : SKSpriteNode){
        nodo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nodo.position = CGPoint(x: 0, y: 0)
        nodo.name = "groundEsq"
        
        if let cena = scene as? GameScene {
            nodo.size = CGSize(width: (cena.size.width), height: (cena.size.height))
            cena.addChild(nodo)
        }else if let cena = scene as? GameScene2 {
            nodo.size = CGSize(width: (cena.size.width), height: (cena.size.height))
            cena.addChild(nodo)
        }else if let cena = scene as? LogicGame {
            nodo.size = CGSize(width: (cena.size.width), height: (cena.size.height))
            
            
            if cena.modelPlayerList.players!.count > 0 {
                //poe a porta do lado oposto da que ele entrou
                if cena.modelPlayerList.players?[0].stateDungeon == 1{
                    var dorDir = SKSpriteNode(imageNamed: "dorDir")
                    dorDir.position = cena.dorBack.position
                    cena.elementAddAuxNode(name: "dorDir", node: cena.dorBack)
                    cena.addChild(dorDir)
                }else if  cena.modelPlayerList.players?[0].stateDungeon == 2 {
                    var dorBaixo = SKSpriteNode(imageNamed: "dorBaixo")
                    dorBaixo.position = cena.dorBack.position
                    cena.elementAddAuxNode(name: "dorCima", node: cena.dorBack)
                    cena.addChild(dorBaixo)
                }
                else if  cena.modelPlayerList.players?[0].stateDungeon == 3 {
                    var dorEsq = SKSpriteNode(imageNamed: "dorEsq")
                    dorEsq.position = cena.dorBack.position
                    cena.elementAddAuxNode(name: "dorEsq", node: cena.dorBack)
                    cena.addChild(dorEsq)
                }
            }
            
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
        nodo.physicsBody?.collisionBitMask = 0
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
        nodo.physicsBody?.collisionBitMask = 0
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
    
    
    func removeAllNodes(scene: Any){
        if let cena = scene as? GameScene {
        }else if let cena = scene as? GameScene2{
        }
        else if let cena = scene as? LogicGame{
            if cena.modelPlayerList.players?[0].stateDungeon == 1 || cena.modelPlayerList.players?[0].stateDungeon == 2 || cena.modelPlayerList.players?[0].stateDungeon == 3{
                
                for nodes in cena.children{
                    if nodes.name != "player1"{
                        if nodes.name != "dorBack"{
                            nodes.removeFromParent()
                            nodes.removeAllActions()
                        }
                    }
                }
            }
        }
    }
    
    
    func createCorInDuengeonEsq(scene: Any){
        if let cena = scene as? GameScene {
            
        }else if let cena = scene as? GameScene2{
            
        }
        else if let cena = scene as? LogicGame{
            cena.backgroundColor = .lightGray
            cena.corDor.name = "itemBlue"
            cena.corDor.position = .zero
            physicsCategoryScene(node: nil, node2: cena.corDor, node3: nil)
            cena.corDor.fillColor = .blue
            cena.addChild(cena.corDor)
            cena.addChild(cena.dorBack)
            
        }
        
    }
    
    func createCorInDuengeonDir(scene: Any){
        if let cena = scene as? GameScene {
            
        }else if let cena = scene as? GameScene2{
            
        }
        else if let cena = scene as? LogicGame{
            cena.backgroundColor = .lightGray
            cena.corDor.name = "itemRed"
            cena.corDor.position = .zero
            physicsCategoryScene(node: nil, node2: cena.corDor, node3: nil)
            cena.corDor.fillColor = .red
            cena.addChild(cena.corDor)
            cena.addChild(cena.dorBack)
            
        }
        
    }
    
    
    func createCorInDuengeonBaixo(scene: Any){
        if let cena = scene as? GameScene {
            
        }else if let cena = scene as? GameScene2{
            
        }
        else if let cena = scene as? LogicGame{
            cena.backgroundColor = .lightGray
            cena.corDor.name = "itemPurple"
            cena.corDor.position = .zero
            physicsCategoryScene(node: nil, node2: cena.corDor, node3: nil)
            cena.corDor.fillColor = .purple
            cena.addChild(cena.corDor)
            cena.addChild(cena.dorBack)
            
        }
        
    }
    
    
    
    func corSecundariaDor(scene: Any, nodo: SKShapeNode){
        if let cena = scene as? GameScene {
            
        }else if let cena = scene as? GameScene2{
            
        }
        else if let cena = scene as? LogicGame{
            cena.backgroundColor = .lightGray
            cena.corSecundariaDor.name = "itemGreen"
            cena.corSecundariaDor.position = cena.dorCima.position
            cena.corSecundariaDor.zPosition = 3
            cena.corSecundariaDor.fillColor = .green
            cena.addChild(cena.corSecundariaDor)
            
        }
        
    }
    
    func createCorJoin(scene: Any, nodo: SKShapeNode){
        
        
        if let cena = scene as? GameScene {
            
        }else if let cena = scene as? GameScene2{
            
        }
        else if let cena = scene as? LogicGame{
            
            cena.corJoin.name = "corJoin"
            cena.corJoin.position.y = cena.misturador.position.y - 80
            physicsCategoryScene(node: nil, node2: cena.corJoin, node3: nil)
            cena.corJoin.fillColor = .yellow
            cena.addChild(cena.corJoin)
            
        }
        
        
    }
    
    func createKey(scene : Any, nodo : SKSpriteNode){
        
        if let cena = scene as? GameScene {
            
        }else if let cena = scene as? GameScene2{
            
        }
        else if let cena = scene as? LogicGame{
            cena.key.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            cena.key.size = CGSize(width: 65, height: 65)
            cena.key.name = "key"
            cena.key.position.y = cena.misturador.position.y + 80
            cena.key.zPosition = 4
            physicsCategoryScene(node: cena.key, node2: nil, node3: nil)
            
            
            cena.addChild(cena.key)
        }
    }
    
    func createEmptyNode(scene : Any, dorEsq : SKNode, dorDir : SKNode, dorBaixo : SKNode, dorCima : SKNode, dorBack: SKNode){
        dorEsq.name = "dorEsq"
        dorDir.name = "dorDir"
        dorBaixo.name = "dorBaixo"
        dorCima.name = "dorCima"
        dorBack.name = "dorBack"
        
        dorDir.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        dorDir.position = CGPoint(x: 161, y: -5  )
        physicsCategoryScene(node: nil, node2: nil, node3: dorDir)
        
        
        dorEsq.position = CGPoint(x: -161, y: -5  )
        physicsCategoryScene(node: nil, node2: nil, node3: dorEsq)
        
        
        dorBaixo.position = CGPoint(x: 0, y: -336  )
        physicsCategoryScene(node: nil, node2: nil, node3: dorBaixo)
        
        dorCima.position = CGPoint(x: 0, y: 357  )
        physicsCategoryScene(node: nil, node2: nil, node3: dorCima)
        
        
        
        physicsCategoryScene(node: nil, node2: nil, node3: dorBack)
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
        //nodo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
        nodo.position = CGPoint(x: -3, y: 174  )
        physicsCategoryScene(node: nodo, node2: nil, node3: nil)
        
        if let cena = scene as? GameScene {
            cena.addChild(nodo)
        }else if let cena = scene as? GameScene2 {
            cena.addChild(nodo)
        }else if let cena = scene as? LogicGame {
            cena.addChild(nodo)
        }
        
    }
    
    func initAllNodes(scene : Any, player : SKSpriteNode, ground : SKSpriteNode,
                      misturador : SKSpriteNode, dorEsq : SKNode, dorDir : SKNode, dorBaixo : SKNode, dorCima : SKNode, dorBack : SKNode, corSecundariaPorta : SKShapeNode, corJoin : SKShapeNode){
        
        createPlayer(scene: scene, nodo: player)
        createGround(scene: scene, nodo: ground)
        createEmptyNode(scene: scene, dorEsq: dorEsq, dorDir: dorDir, dorBaixo: dorBaixo, dorCima: dorCima, dorBack: dorBack)
        createMisturador(scene: scene, nodo: misturador)
        corSecundariaDor(scene: scene, nodo: corSecundariaPorta)
        createCorJoin(scene: scene, nodo: corJoin)
    }
    
    func physicsCategoryScene(node : SKSpriteNode?, node2 : SKShapeNode?, node3 : SKNode?){
        
        if node != nil {
            node?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
            node?.physicsBody?.categoryBitMask = 0b10
            node?.physicsBody?.contactTestBitMask = 0b1
            node?.physicsBody?.collisionBitMask = 0
            node?.physicsBody?.isDynamic = false
            node?.physicsBody?.allowsRotation = false
            node?.physicsBody?.affectedByGravity = false
        }else if node2 != nil{
            node2?.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            node2?.physicsBody?.affectedByGravity = false
            node2?.physicsBody?.isDynamic = true
            node2?.physicsBody?.categoryBitMask = 0b10
            node2?.physicsBody?.contactTestBitMask = 0b1
            node2?.physicsBody?.collisionBitMask = 0
            node2?.physicsBody?.allowsRotation = false
            node2?.zPosition = 4
        }
        else if node3 != nil {
            node3?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 80))
            node3?.physicsBody?.categoryBitMask = 0b10
            node3?.physicsBody?.contactTestBitMask = 0b1
            node3?.physicsBody?.collisionBitMask = 0
            node3?.physicsBody?.isDynamic = false
            node3?.physicsBody?.allowsRotation = false
            node3?.physicsBody?.affectedByGravity = false
        }
        
        
    }
    
    
}
