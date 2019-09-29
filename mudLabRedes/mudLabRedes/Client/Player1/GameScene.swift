//
//  playerControl.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 21/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//


import SpriteKit
import GameplayKit
import UIKit
class GameScene: SKScene, SKPhysicsContactDelegate {
    
 
    var player1 = SKSpriteNode(imageNamed: "p1")
    var player2 = SKSpriteNode(imageNamed: "p2")
   var corSecundariaDor = SKShapeNode(circleOfRadius: 10)
    var corJoin = SKShapeNode(circleOfRadius: 15)
    var move = false
    var client : UDPClient?
    var ground =
        SKSpriteNode(imageNamed: "bg")
    var misturador = SKSpriteNode(imageNamed: "misturador")
    var dorEsq = SKNode()
    var dorDir = SKNode()
    var dorBaixo = SKNode()
    var dorCima = SKNode()
     var dorBack = SKNode()
 
    
   
    
    override func didMove(to view: SKView) {
      //  msgWorld.delegate = self
        physicsWorld.contactDelegate = self
        scene?.name = "player1"
        client = UDPClient(scene: self, scene2: nil)
        client?.sendInitialFrame(position: player1.position, node: player1)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
           print("TextField did end editing method called\(textField.text!)")
       }
    

    override public func touchesBegan ( _ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
       player1.position = location
        client?.sendFrame(node: player1)
 
        }
    }
    
    var timeSpawn: Double = 0
    override func update(_ currentTime: TimeInterval) {
//        if timeSpawn + 0.5 <= currentTime {
//        print("hora de mandar")
//        client?.sendFrame(node: player1)
//        timeSpawn = currentTime
//        }
          //client?.sendFrame(node: player1)
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
          
          
          if((nodeA.name == "player1" && nodeB.name == "misturador") ||
              (nodeA.name == "misturador" && nodeB.name == "player1")){
              
              print("Misturador")
          }
          //--------------- p2
          
          if((nodeA.name == "player2" && nodeB.name == "dorEsq") ||
              (nodeA.name == "dorEsq" && nodeB.name == "player2")){
              print("porta Esquerda")
              
              
          }
          
          if((nodeA.name == "player2" && nodeB.name == "dorDir") ||
              (nodeA.name == "dorDir" && nodeB.name == "player2")){
              
              print("porta Direita")
              
          }
          
          
          if((nodeA.name == "player2" && nodeB.name == "dorBaixo") ||
              (nodeA.name == "dorBaixo" && nodeB.name == "player2")){
              print("porta Baixo")
              
              
          }
          
          if((nodeA.name == "player2" && nodeB.name == "dorCima") ||
              (nodeA.name == "dorCima" && nodeB.name == "player2")){
              print("porta Cima")
      
          }
          if((nodeA.name == "player2" && nodeB.name == "backDor") ||
              (nodeA.name == "backDor" && nodeB.name == "player2")){
              
              print("Encontou na porta de volta")
          }
          
          if((nodeA.name == "player2" && nodeB.name == "itemRed") ||
              (nodeA.name == "itemRed" && nodeB.name == "player2")){
              
              print("Encontou na porta de volta")
          }
          
          if((nodeA.name == "player2" && nodeB.name == "itemBlue") ||
              (nodeA.name == "itemBlue" && nodeB.name == "player2")){
              
              print("Encontou na porta de volta")
          }
          
          if((nodeA.name == "player2" && nodeB.name == "itemYellow") ||
              (nodeA.name == "itemYellow" && nodeB.name == "player2")){
              
              print("Encontou na porta de volta")
          }
          
          
          if((nodeA.name == "player2" && nodeB.name == "misturador") ||
              (nodeA.name == "misturador" && nodeB.name == "player2")){
              
              print("Misturador")
          }
          
      }
    
    
    
   
}
