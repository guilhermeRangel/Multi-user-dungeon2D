//
//  playerControl.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import GameplayKit

class GameScene2: SKScene, SKPhysicsContactDelegate {
    var player1 = SKSpriteNode(imageNamed: "p1")
       var player2 = SKSpriteNode(imageNamed: "p2")
       var ground =
              SKSpriteNode(imageNamed: "bg")
        var groundDors = SKSpriteNode(imageNamed: "esq")
       var misturador = SKSpriteNode(imageNamed: "misturador")
       
      var corSecundariaDor = SKShapeNode(circleOfRadius: 10)
         var corDor = SKShapeNode(circleOfRadius: 25)
         var corJoin = SKShapeNode(circleOfRadius: 15)
       
       var move = false
       var client : UDPClient?
      
       
       var dorEsq = SKNode()
       var dorDir = SKNode()
       var dorBaixo = SKNode()
       var dorCima = SKNode()
        var dorBack = SKNode()
    
       
      var auxNodeDor : SKSpriteNode?

        var key = SKSpriteNode(imageNamed: "key")
        var createNodes : CreateNodes = CreateNodes()
        
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        scene?.name = "player2"
        client = UDPClient(scene: nil, scene2: self)
        client?.sendInitialFrame(position: player2.position, node: player2)
        
        
    }
    
    
    func elementAddAuxNode(name : String, node : SKNode){
         auxNodeDor = SKSpriteNode(imageNamed: name)
         auxNodeDor?.position = node.position
         auxNodeDor?.name = node.name
         auxNodeDor?.zPosition = 3
         addChild(auxNodeDor!)
     }

    
    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let location = touches.first?.location(in: self){
            player2.position = location
            client?.sendFrame(node: player2)
            
        }
    }
    
    
    var timeSpawn: Double = 0
       override func update(_ currentTime: TimeInterval) {
//        if timeSpawn + 0.5 <= currentTime {
//           print("hora de mandar")
//           client?.sendFrame(node: player2)
//           timeSpawn = currentTime
//           }
            client?.sendFrame(node: player2)
       }
    
    
    
   public func didBegin(_ contact: SKPhysicsContact) {
              
              guard let nodeA = contact.bodyA.node else {return}
              guard let nodeB = contact.bodyB.node else { return}
              
              
              if((nodeA.name == "player1" && nodeB.name == "dorEsq") ||
                  (nodeA.name == "dorEsq" && nodeB.name == "player1")){
                  print("porta Esquerda")
                  
                  dorBack.position = dorDir.position
                 // modelPlayerList.players?[0].stateDungeon = 1
                  createNodes.removeAllNodes(scene: self)
                  createNodes.createCorInDuengeonEsq(scene: self)
                  createNodes.createGroundEsq(scene: self, nodo: groundDors)
                  
              }
              
              if((nodeA.name == "player1" && nodeB.name == "dorDir") ||
                  (nodeA.name == "dorDir" && nodeB.name == "player1")){
                  
                  print("porta Direita")
                  dorBack.position = dorEsq.position
                 // modelPlayerList.players?[0].stateDungeon = 3
                  createNodes.removeAllNodes(scene: self)
                  createNodes.createCorInDuengeonDir(scene: self)
                  createNodes.createGroundEsq(scene: self, nodo: groundDors)
                  
              }
              
              
              if((nodeA.name == "player1" && nodeB.name == "dorBaixo") ||
                  (nodeA.name == "dorBaixo" && nodeB.name == "player1")){
                  print("porta Baixo")
                  
                  
                  dorBack.position = dorCima.position
                 // modelPlayerList.players?[0].stateDungeon = 2
                  createNodes.removeAllNodes(scene: self)
                  createNodes.createCorInDuengeonBaixo(scene: self)
                  createNodes.createGroundEsq(scene: self, nodo: groundDors)
                  
              }
              
              if((nodeA.name == "player1" && nodeB.name == "dorCima") ||
                  (nodeA.name == "dorCima" && nodeB.name == "player1")){
                  //emitir alerta
                  
   //               if modelPlayerList.players?[0].key == true {
   //                   print("PARABENSSSSSSSS")
   //               }
                  
              }
              
              if((nodeA.name == "player1" && nodeB.name == "dorBack") ||
                  (nodeA.name == "dorBack" && nodeB.name == "player1")){
                  
                  print("Encontou na porta de volta")
                  
                  
                  self.removeAllChildren()
                //  modelPlayerList.players?[0].stateDungeon = 0
                  createNodes.initAllNodes(scene: self, player: player1, ground: ground, misturador: misturador, dorEsq: dorEsq, dorDir: dorDir, dorBaixo: dorBaixo, dorCima: dorCima, dorBack: dorBack, corSecundariaPorta: corSecundariaDor, corJoin : corJoin)
                  createNodes.createPlayer2(scene: self, nodo: player2)
              }
              
              if((nodeA.name == "player1" && nodeB.name == "itemRed") ||
                  (nodeA.name == "itemRed" && nodeB.name == "player1")){
                  print("Encontou o vermelho")
                  corDor.removeFromParent()
                  //modelPlayerList.players?[0].cores = 2
              }
              
              if((nodeA.name == "player1" && nodeB.name == "itemBlue") ||
                  (nodeA.name == "itemBlue" && nodeB.name == "player1")){
                  print("Pegou a cor azul")
                  corDor.removeFromParent()
                  //modelPlayerList.players?[0].cores = 1
              }
              
              if((nodeA.name == "player1" && nodeB.name == "itemPurple") ||
                  (nodeA.name == "itemPurple" && nodeB.name == "player1")){
                  print("pegou o purple")
                  corDor.removeFromParent()
                 // modelPlayerList.players?[0].cores = 3
                  
              }
              
              if((nodeA.name == "player1" && nodeB.name == "itemYellow") ||
                  (nodeA.name == "itemYellow" && nodeB.name == "player1")){
                  print("Encontou na porta de volta")
              }
              
              if((nodeA.name == "player1" && nodeB.name == "itemGreen") ||
                  (nodeA.name == "itemGreen" && nodeB.name == "player1")){ self.removeAllChildren()
                                 //modelPlayerList.players?[0].stateDungeon = 0
                                 
                                 createNodes.initAllNodes(scene: self, player: player1, ground: ground, misturador: misturador, dorEsq: dorEsq, dorDir: dorDir, dorBaixo: dorBaixo, dorCima: dorCima, dorBack: dorBack, corSecundariaPorta: corSecundariaDor, corJoin : corJoin)
                                 
                                 createNodes.createPlayer2(scene: self, nodo: player2)
                  print("pegou o verde")
              }
              
              
              
              
              
              if((nodeA.name == "player1" && nodeB.name == "misturador") ||
                  (nodeA.name == "misturador" && nodeB.name == "player1")){
                  //print de duvidas
                  print("Misturador")
              }
              
              if((nodeA.name == "player1" && nodeB.name == "corJoin") ||
                  (nodeA.name == "corJoin" && nodeB.name == "player1")){
                  
   //               if modelPlayerList.players?[0].cores == 1 {
   //                   corJoin.removeFromParent()
   //                   createNodes.createKey(scene: self, nodo: key)
   //                   print("verificando a mistura das cores primarias...")
   //               }
                  
                  print("corJoin")
              }
              
              if((nodeA.name == "player1" && nodeB.name == "key") ||
                  (nodeA.name == "key" && nodeB.name == "player1")){
                  //modelPlayerList.players?[0].key = true
                  key.removeFromParent()
                  print("pegou a key")
              }
              //--------------- p2
              
              if((nodeA.name == "player2" && nodeB.name == "dorEsq") ||
                  (nodeA.name == "dorEsq" && nodeB.name == "player2")){
                  print("porta Esquerda")
                  
                  dorBack.position = dorDir.position
                 // modelPlayerList.players?[1].stateDungeon = 1
                  createNodes.removeAllNodes(scene: self)
                  createNodes.createCorInDuengeonEsq(scene: self)
                  createNodes.createGroundEsq(scene: self, nodo: groundDors)
                  
              }
              
              if((nodeA.name == "player2" && nodeB.name == "dorDir") ||
                  (nodeA.name == "dorDir" && nodeB.name == "player2")){
                  
                  print("porta Direita")
                  dorBack.position = dorEsq.position
                 // modelPlayerList.players?[1].stateDungeon = 3
                  createNodes.removeAllNodes(scene: self)
                  createNodes.createCorInDuengeonDir(scene: self)
                  createNodes.createGroundEsq(scene: self, nodo: groundDors)
                  
              }
              
              
              if((nodeA.name == "player2" && nodeB.name == "dorBaixo") ||
                  (nodeA.name == "dorBaixo" && nodeB.name == "player2")){
                  print("porta Baixo")
                  
                  
                  dorBack.position = dorCima.position
                 // modelPlayerList.players?[1].stateDungeon = 2
                  createNodes.removeAllNodes(scene: self)
                  createNodes.createCorInDuengeonBaixo(scene: self)
                  createNodes.createGroundEsq(scene: self, nodo: groundDors)
                  
              }
              
              if((nodeA.name == "player2" && nodeB.name == "dorCima") ||
                  (nodeA.name == "dorCima" && nodeB.name == "player2")){
                  //emitir alerta
                  
   //               if modelPlayerList.players?[1].key == true {
   //                   print("PARABENSSSSSSSS")
   //               }
                  
              }
              
              if((nodeA.name == "player2" && nodeB.name == "dorBack") ||
                  (nodeA.name == "dorBack" && nodeB.name == "player2")){
                  
                  print("Encontou na porta de volta")
                  
                  
                  self.removeAllChildren()
                  //modelPlayerList.players?[1].stateDungeon = 0
                  createNodes.initAllNodes(scene: self, player: player1, ground: ground, misturador: misturador, dorEsq: dorEsq, dorDir: dorDir, dorBaixo: dorBaixo, dorCima: dorCima, dorBack: dorBack, corSecundariaPorta: corSecundariaDor, corJoin : corJoin)
                  createNodes.createPlayer2(scene: self, nodo: player2)
              }
              
              if((nodeA.name == "player2" && nodeB.name == "itemRed") ||
                  (nodeA.name == "itemRed" && nodeB.name == "player2")){
                  print("Encontou o vermelho")
                  corDor.removeFromParent()
                 // modelPlayerList.players?[1].cores = 2
              }
              
              if((nodeA.name == "player2" && nodeB.name == "itemBlue") ||
                  (nodeA.name == "itemBlue" && nodeB.name == "player2")){
                  print("Pegou a cor azul")
                  corDor.removeFromParent()
                //  modelPlayerList.players?[1].cores = 1
              }
              
              if((nodeA.name == "player2" && nodeB.name == "itemPurple") ||
                  (nodeA.name == "itemPurple" && nodeB.name == "player2")){
                  print("pegou o purple")
                  corDor.removeFromParent()
                  //modelPlayerList.players?[1].cores = 3
                  
              }
              
              if((nodeA.name == "player2" && nodeB.name == "itemYellow") ||
                  (nodeA.name == "itemYellow" && nodeB.name == "player2")){
                  print("Encontou na porta de volta")
              }
              
              if((nodeA.name == "player2" && nodeB.name == "itemGreen") ||
                  (nodeA.name == "itemGreen" && nodeB.name == "player2")){ self.removeAllChildren()
                           //      modelPlayerList.players?[1].stateDungeon = 0
                                 
                                 createNodes.initAllNodes(scene: self, player: player1, ground: ground, misturador: misturador, dorEsq: dorEsq, dorDir: dorDir, dorBaixo: dorBaixo, dorCima: dorCima, dorBack: dorBack, corSecundariaPorta: corSecundariaDor, corJoin : corJoin)
                                 
                                 createNodes.createPlayer2(scene: self, nodo: player2)
                  print("pegou o verde")
              }
              
              
              
              
              
              if((nodeA.name == "player2" && nodeB.name == "misturador") ||
                  (nodeA.name == "misturador" && nodeB.name == "player2")){
                  //print de duvidas
                  print("Misturador")
              }
              
              if((nodeA.name == "player2" && nodeB.name == "corJoin") ||
                  (nodeA.name == "corJoin" && nodeB.name == "player2")){
                  
   //               if modelPlayerList.players?[1].cores == 1 {
   //                   corJoin.removeFromParent()
   //                   createNodes.createKey(scene: self, nodo: key)
   //                   print("verificando a mistura das cores primarias...")
   //               }
                  
                  print("corJoin")
              }
              
              if((nodeA.name == "player2" && nodeB.name == "key") ||
                  (nodeA.name == "key" && nodeB.name == "player2")){
                  //modelPlayerList.players?[1].key = true
                  key.removeFromParent()
                  print("pegou a key")
              }
          
          
      }
        
    }
    
    

